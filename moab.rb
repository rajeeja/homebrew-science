require 'formula'

class Moab < Formula
  homepage 'https://sigma.mcs.anl.gov/moab-library'
  url 'ftp://ftp.mcs.anl.gov/pub/fathom/moab-4.7.0RC1.tar.gz'
  sha1 'ad69a021b49d7a9870ff908945d8c9221f51b66b'

  option 'without-check', "Skip build-time checks (not recommended)"

  depends_on :autoconf
  depends_on :automake
  depends_on :libtool
  depends_on 'netcdf'
  depends_on 'hdf5'
  depends_on :fortran if build.with? 'check'

  def install
    system "autoreconf", "--force", "--install"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--libdir=#{libexec}/lib"

    system "make install"
    # Moab installs non-lib files in libdir. Link only the libraries.
    lib.install_symlink Dir["#{libexec}/lib/*.a"]
    system "make check" if build.with? 'check'
  end
end
