class CurlMcp < Formula
  desc "curl-mcp MCP HTTP client for Model Context Protocol tools"
  homepage "https://github.com/calibress/curl-mcp"
  url "https://github.com/calibress/curl-mcp/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "a5edab55cafea4f3f98721a5a171422261894d564197907258119426fdfa740d"
  license "MIT"

  head "https://github.com/calibress/curl-mcp.git", branch: "main"

  depends_on "node"

  def install
    system "npm", "install"
    system "npm", "run", "build"

    libexec.install Dir["*"]

    (bin/"curl-mcp").write <<~SH
      #!/bin/sh
      cd "#{libexec}"
      exec "#{Formula["node"].opt_bin}/node" "packages/mcp-stdio/dist/server.js" "$@"
    SH
    chmod 0755, bin/"curl-mcp"
  end

  test do
    # Basic smoke test: ensure the binary exists and is executable.
    assert_predicate bin/"curl-mcp", :executable?
  end
end
