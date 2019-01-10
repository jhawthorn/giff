require "giff/diff"
require "giff/gem_file"
require "giff/tarball"
require "giff/version"

require "tempfile"

module Giff
  def self.gunzip(input)
    io = StringIO.new(input)
    Zlib::GzipReader.new(io).read
  end

  def self.diff(txt_a, txt_b)
    Tempfile.open("a") do |a|
      a.puts txt_a
      a.flush

      Tempfile.open("b") do |b|
        b.puts txt_b
        b.flush

        return `diff -u #{a.path} #{b.path}`
      end
    end
  end
end
