require "formula"

class Moab < Formula
  homepage "http://sigma.mcs.anl.gov"
  url "http://ftp.mcs.anl.gov/pub/fathom/moab-nightly.tar.gz"
  sha1 "78fddbda313e7f141014268a84c57ec23b6baf28"

  depends_on :fortran
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  depends_on 'netcdf'
  depends_on 'hdf5'

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
  end
end

