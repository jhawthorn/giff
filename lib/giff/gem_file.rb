require "giff/tarball"
require "zlib"

module Giff
  # "gem file" not a "gemfile"
  class GemFile
    attr_reader :checksums, :metadata, :data

    def initialize(io)
      io = File.open(io) if io.is_a?(String)

      tarball = Tarball.new(io)
      @checksums = Giff.gunzip(tarball.read("checksums.yaml.gz"))
      @metadata = Giff.gunzip(tarball.read("metadata.gz"))
      @data = Tarball.new(StringIO.new(tarball.read("data.tar.gz")), gz: true)
      #@tarball = tarball
    end
  end
end
