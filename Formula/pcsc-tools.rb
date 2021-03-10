require "language/perl"

class PcscTools < Formula
  include Language::Perl::Shebang

  desc "Tools to test a PC/SC driver, card or reader or send commands"
  homepage "http://ludovic.rousseau.free.fr/softwares/pcsc-tools/"
  url "http://ludovic.rousseau.free.fr/softwares/pcsc-tools/pcsc-tools-1.5.7.tar.bz2"
  sha256 "e0ea8f8496d5bcf5316da913869ba95b925d0405c2aaade801c0d6ce7697699d"
  license "GPL-2.0"

  option "with-gui", "Install `gscriptor` GTK+3 program"

  if build.with? "gui"
    depends_on "cairo"
    depends_on "glib"
    depends_on "gobject-introspection"
    depends_on "gtk+3"
  end

  uses_from_macos "perl"

  resource "Chipcard::PCSC::Card" do
    url "https://cpan.metacpan.org/authors/id/W/WH/WHOM/pcsc-perl-1.4.14.tar.bz2"
    sha256 "2722b7e5543e4faf3ba1ec6b29a7dfec6d92be1edec09d0a3191992d4d88c69d"
  end

  if build.with? "gui"
    resource "ExtUtils::PkgConfig" do
      url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/ExtUtils-PkgConfig-1.16.tar.gz"
      sha256 "bbeaced995d7d8d10cfc51a3a5a66da41ceb2bc04fedcab50e10e6300e801c6e"
    end

    resource "Glib" do
      url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-1.3293.tar.gz"
      sha256 "7316a0c1e7cc5cb3db7211214f45d7bdc2354365a680ac4bd3ac8bf06d1cb500"
    end

    resource "Glib::Object::Introspection" do
      url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-Object-Introspection-0.049.tar.gz"
      sha256 "464628cb9dd028b10438c23892de6f8a30202355a4e4eb01bfd13b8cfe35af57"
    end

    resource "Cairo" do
      url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/Cairo-1.109.tar.gz"
      sha256 "8219736e401c2311da5f515775de43fd87e6384b504da36a192f2b217643077f"
    end

    resource "Cairo::GObject" do
      url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/Cairo-GObject-1.005.tar.gz"
      sha256 "8d896444d71e1d0bca3d24e31e5d82bd0d9542aaed91d1fb7eab367bce675c50"
    end

    resource "Gtk3" do
      url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/Gtk3-0.038.tar.gz"
      sha256 "70dc4bf2aa74981c79e15fd298d998e05a92eba4811f1ad5c9f1f4de37737acc"
    end
  end

  def install
    ENV.prepend_create_path "PERL5LIB", buildpath/"build_deps/lib/perl5"
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    build_only_deps = %w[ExtUtils::PkgConfig]
    resources.each do |r|
      r.stage do
        install_base = if build_only_deps.include? r.name
          buildpath/"build_deps"
        else
          libexec
        end
        system "perl", "Makefile.PL", "INSTALL_BASE=#{install_base}"
        system "make", "install"
      end
    end

    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"

    system "make", "install"

    if build.without? "gui"
      rm bin/"gscriptor"
      rm man1/"gscriptor.1p"
    end

    # Disable dynamic selection of perl which may cause segfault when an
    # incompatible perl is picked up.
    # https://github.com/Homebrew/homebrew-core/issues/4936
    bin.find { |f| rewrite_shebang detected_perl_shebang, f }

    bin.env_script_all_files(libexec/"bin", PERL5LIB: ENV["PERL5LIB"])
  end

  test do
    system "#{bin}/pcsc_scan", "-V"

    atr = "3B A7 00 40 18 80 65 A2 08 01 01 52"
    assert_match "ATR: #{atr}", shell_output("#{bin}/ATR_analysis #{atr}")
  end
end
