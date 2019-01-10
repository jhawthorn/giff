require "giff/diff"
require "giff/gem_file"
require "giff/tarball"
require "giff/version"

module Giff
  def self.gunzip(input)
    io = StringIO.new(input)
    Zlib::GzipReader.new(io).read
  end
end
