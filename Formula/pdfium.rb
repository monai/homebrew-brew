class Pdfium < Formula
  desc "Library for PDF manipulation and rendering"
  homepage "https://github.com/bblanchon/pdfium-binaries"
  url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium%2F5010/pdfium-mac-x64.tgz"
  version "103.0.5010.0"
  sha256 "290b312764715d1a55339caa4bf1dc3561dc841186b60b3a118bc54576635797"
  license "Apache-2.0"

  def install
    prefix.install Dir["*"]

    (lib/"pkgconfig/#{name}.pc").write <<~EOS
      prefix=#{prefix}
      exec_prefix=${prefix}
      libdir=${exec_prefix}/lib
      includedir=${prefix}/include

      Name: PDFium
      Description: #{desc}
      Version: #{version}
      Libs: -L${libdir} -l#{name}
      Cflags: -I${includedir}
    EOS
  end

  test do
    system "pkg-config", "pdfium"
  end
end
