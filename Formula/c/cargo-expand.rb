class CargoExpand < Formula
  desc "Show what Rust code looks like with macros expanded"
  homepage "https://github.com/dtolnay/cargo-expand"
  url "https://github.com/dtolnay/cargo-expand/archive/refs/tags/1.0.99.tar.gz"
  sha256 "7d0b4a02283843b13098a9301e70a60928f246676cfef7b017a3b8cbe443b987"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/dtolnay/cargo-expand.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "73c53ede77e48b9ff21982ec0d3996ab7acee1aef647d5269d5d174203a81489"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4de9b9437bbf4ca12cbb5c99304af5446229c7a14f194d6c7ffcfc766ef3d105"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bb769a1058f3fcefd1d69ed136a7833d9b74432cd28aaa497324db2038ce1e3f"
    sha256 cellar: :any_skip_relocation, sonoma:        "698c021cd184e1f388cbacf58b8b4e62968dd0a1a2a1c3f6090c0133950379f2"
    sha256 cellar: :any_skip_relocation, ventura:       "5396659f49b909b4e8b9ab180a6066bb9ec1db24f3c593ed5d8b189ed5e2457e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7bc03b9a487953b34e9121b08ba642ad4addfca1254d4581bd69b36e54df1998"
  end

  depends_on "rust" => :build
  depends_on "rustup" => :test

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    ENV.prepend_path "PATH", Formula["rustup"].bin
    system "rustup", "default", "stable"
    system "rustup", "set", "profile", "minimal"

    system "cargo", "new", "hello_world", "--lib"
    cd "hello_world" do
      output = shell_output("cargo expand 2>&1")
      assert_match "use std::prelude", output
    end
  end
end
