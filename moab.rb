require "formula"

class Moab < Formula
  homepage "http://sigma.mcs.anl.gov"
  url "http://ftp.mcs.anl.gov/pub/fathom/moab-nightly.tar.gz"
  sha1 "cbc4fef48c5bea02c718034efc3dc2c7c7b1615c"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  depends_on 'netcdf'
  depends_on 'hdf5'
  depends_on 'gcc'

  def install

    args = %W[
      --prefix=#{prefix}
      --disable-debug
      --disable-dependency-tracking
      --with-netcdf=#{Formula["netcdf"].opt_prefix}
      --with-hdf5=#{Formula["hdf5"].opt_prefix}
    ]
    system "autoreconf",  "--force", "--install"
    system "./configure", *args
    system "make", "install"
    system "make", "check"
  end
end
