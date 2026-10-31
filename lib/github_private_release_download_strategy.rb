# typed: false
# frozen_string_literal: true

require "download_strategy"
require "json"
require "utils/github/api"

# Downloads a release asset from a (possibly private) GitHub repository.
#
# Homebrew dropped its built-in private-release strategy, so this tap ships a
# small one. The asset is fetched through the GitHub REST API with the GitHub
# login you already have: HOMEBREW_GITHUB_API_TOKEN, then `gh auth token`
# (Homebrew's or any `gh` on PATH), then the macOS keychain. The token is only
# sent to api.github.com; curl drops the Authorization header when the API
# redirects to GitHub's object storage.
#
# Use with: url "https://github.com/OWNER/REPO/releases/download/TAG/FILE",
#   using: GitHubPrivateReleaseDownloadStrategy
class GitHubPrivateReleaseDownloadStrategy < CurlDownloadStrategy
  URL_PATTERN = %r{\Ahttps://github\.com/([^/]+)/([^/]+)/releases/download/([^/]+)/([^/?#]+)\z}
  API = "https://api.github.com"

  def initialize(url, name, version, **meta)
    super
    match = URL_PATTERN.match(@url)
    raise CurlDownloadStrategyError.new(@url, "Invalid GitHub release asset URL") unless match

    @owner, @repo, @tag, @filename = match.captures
  end

  private

  def resolve_url_basename_time_file_size(_url, timeout: nil)
    token = github_token
    # Without a GitHub login, fall back to a plain download. That works once
    # the repository is public; for a private one it fails with a 404.
    return super if token.blank?

    meta[:headers] = []
    asset_url = asset_api_url(token)
    meta[:headers] = [
      "Accept: application/octet-stream",
      "Authorization: Bearer #{token}",
      "X-GitHub-Api-Version: 2022-11-28",
    ]
    [asset_url, @filename, nil, nil, nil, false]
  end

  def github_token
    @github_token ||= GitHub::API.credentials.presence || gh_cli_token
  end

  # Homebrew itself only asks a Homebrew-installed `gh`; also accept one on
  # PATH or in the usual install locations.
  def gh_cli_token
    candidates = [which("gh"), "/opt/homebrew/bin/gh", "/usr/local/bin/gh"].compact.map(&:to_s).uniq
    candidates.each do |gh|
      next unless File.executable?(gh)

      out, _, status = system_command(gh, args:         ["auth", "token", "--hostname", "github.com"],
                                          print_stderr: false, verbose: false).to_a
      return out.chomp if status.success? && out.chomp.present?
    end
    nil
  end

  def asset_api_url(token)
    @asset_api_url ||= begin
      result = curl_output("--fail", "--silent", "--show-error",
                           "--header", "Accept: application/vnd.github+json",
                           "--header", "Authorization: Bearer #{token}",
                           "#{API}/repos/#{@owner}/#{@repo}/releases/tags/#{@tag}")
      unless result.success?
        raise CurlDownloadStrategyError.new(@url, "Could not read release #{@tag} of #{@owner}/#{@repo}")
      end

      asset = JSON.parse(result.stdout).fetch("assets", []).find { |a| a["name"] == @filename }
      raise CurlDownloadStrategyError.new(@url, "Release #{@tag} has no asset #{@filename}") if asset.nil?

      "#{API}/repos/#{@owner}/#{@repo}/releases/assets/#{asset.fetch("id")}"
    end
  end
end
