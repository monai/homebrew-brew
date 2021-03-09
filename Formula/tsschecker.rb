class Tsschecker < Formula
  desc "Powerfull tool to check TSS signing status of various devices and firmwares"
  homepage "https://github.com/tihmstar/tsschecker"
  url "https://github.com/tihmstar/tsschecker/archive/304.tar.gz"
  sha256 "a83b76d72c4434a29907a6072193488f9034fcff793d33c349590ead82de4275"
  license "LGPL-3.0"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libfragmentzip"
  depends_on "libirecovery"
  depends_on "libplist"

  uses_from_macos "zlib"
  uses_from_macos "curl"

  resource "jssy" do
    url "https://github.com/tihmstar/jssy.git", revision: "e17d3c8ec5216692efbbe59bbe9801bb7661e07d"
  end

  def install
    inreplace "configure.ac" do |s|
      s.gsub! "$(git rev-list --count HEAD | tr -d '\\n')", "304"
      s.gsub! "$(git rev-parse HEAD | tr -d '\\n')", "b9d193aa6e6d24421094873c830692d02d8b32f5"
      s.gsub! "libirecovery >= 0.2.0", "libirecovery-1.0 >= 0.2.0"
      s.gsub! "libplist >= 2.0.0", "libplist-2.0 >= 2.0.0"
    end

    (buildpath/"external/jssy").install resource("jssy")

    system "./autogen.sh", "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    system "#{bin}/tsschecker", "--help"
  end
end
