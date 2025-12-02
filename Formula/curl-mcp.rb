class CurlMcp < Formula
  desc "curl-mcp MCP HTTP client for Model Context Protocol tools"
  homepage "https://github.com/calibress/curl-mcp"
  url "https://github.com/calibress/curl-mcp/archive/refs/tags/v0.0.5.tar.gz"
  sha256 "90ab84cbe481da503a7d34e4a304672fa25e47ee482940ae096caf166101bbbf"
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
