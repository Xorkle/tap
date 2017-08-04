require "language/go"

class Tmsu < Formula
  desc "Tag your files and then access them through a nifty virtual filesystem"

  homepage "https://tmsu.org/"

  url "https://github.com/oniony/TMSU.git",
      :revision => "442862c2413d923cdfaa236e8f80c07ea8df900b"


  depends_on "go" => :build

  go_resource "github.com/mattn/go-sqlite3" do
    url "https://github.com/mattn/go-sqlite3.git",
        :revision => "afe454f6220b3972691678af2c5579781563183f"
  end

  go_resource "github.com/hanwen/go-fuse/fuse" do
    url "https://github.com/hanwen/go-fuse.git",
        :revision => "5690be47d614355a22931c129e1075c25a62e9ac"
  end

  go_resource "golang.org/x/net" do
    url "https://go.googlesource.com/net.git",
        :revision => "5f8847ae0d0e90b6a9dc8148e7ad616874625171"
  end

  def install
    ENV["GOPATH"] = buildpath
    Language::Go.stage_deps resources, buildpath/"src"

    system "make", "compile"

    bin.install "bin/tmsu"
    sbin.install "misc/bin/mount.tmsu"
    man1.install "misc/man/tmsu.1"
    (share/"zsh/site-functions").install "misc/zsh/_tmsu"
  end

  test do
    system bin/"tmsu", "--version"
  end
end
