class GatewayGo < Formula
  desc "GateWay Client for OpenIoTHub"
  homepage "https://github.com/OpenIoTHub"
  url "https://github.com/OpenIoTHub/gateway-go/archive/refs/tags/v0.3.10.tar.gz"
  sha256 "1a5b1850e0fa5735540d24b4b624a580f93af06edec7a0837ad3cf932fe8153c"
  license "MIT"
  head "https://github.com/OpenIoTHub/gateway-go.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "52bfaf3a577d062a8179c5eda964a1d5e8b516df2e91c68f27f4c963796da9ed"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "92a1c81929970d403b738ca8c61504e81010fe428b73c64f364da3891c6cd03d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e7e1b478cdfb830538db5368e61798d3bf12513f5bdf573ccccb84fef065c6fb"
    sha256 cellar: :any_skip_relocation, sonoma:        "3f3f85143d7edb64d35af1ed8f9ab9d19e00fd97b3c9a96a279aec7d377d229b"
    sha256 cellar: :any_skip_relocation, ventura:       "3f3f85143d7edb64d35af1ed8f9ab9d19e00fd97b3c9a96a279aec7d377d229b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "638e06b0d09760cd35b76092bef7e7fad53967bfa39c4f1968681f736272743c"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/OpenIoTHub/gateway-go/info.Version=#{version}
      -X github.com/OpenIoTHub/gateway-go/info.Commit=
      -X github.com/OpenIoTHub/gateway-go/info.Date=#{Time.now.iso8601}
      -X github.com/OpenIoTHub/gateway-go/info.BuiltBy=homebrew
    ]
    system "go", "build", *std_go_args(ldflags:)
    (etc/"gateway-go").install "gateway-go.yaml"
  end

  service do
    run [opt_bin/"gateway-go", "-c", etc/"gateway-go.yaml"]
    keep_alive true
    error_log_path var/"log/gateway-go.log"
    log_path var/"log/gateway-go.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gateway-go -v 2>&1")
    assert_match "config created", shell_output("#{bin}/gateway-go init --config=gateway.yml 2>&1")
    assert_path_exists testpath/"gateway.yml"
  end
end
