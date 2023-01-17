class Youplot < Formula
  desc "A command line tool that draw plots on the terminal"
  homepage "https://github.com/red-data-tools/YouPlot/"
  url "https://github.com/red-data-tools/YouPlot/archive/v0.4.5.tar.gz"
  sha256 "aa7339139bc4ea9aa0b2279e4e8052fde673a60ad47e87d50fde06626dc2b3c3"
  license "MIT"

  depends_on "ruby"

  resource "unicode_plot" do
    url "https://rubygems.org/downloads/unicode_plot-0.0.5.gem"
    sha256 "91ce6237bca67a3b969655accef91024c78ec6aad470fcddeb29b81f7f78f73b"
  end

  resource "enumerable-statistics" do
    url "https://rubygems.org/downloads/enumerable-statistics-2.0.7.gem"
    sha256 "eeb84581376305327b31465e7b088146ea7909d19eb637d5677e51f099759636"
  end

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "#{name}.gemspec"
    system "gem", "install", "#{name}-#{version}.gem"
    bin.install libexec/"bin/#{name}", libexec/"bin/uplot"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    system bin/"youplot --version"
    system bin/"uplot --version"
  end
end
