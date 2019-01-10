require 'minitar'

module Giff
  class Tarball
    def initialize(io, gz: false)
      io = Zlib::GzipReader.new(io) if gz

      @contents = Hash[
        Archive::Tar::Minitar::Input.each_entry(io).map do |e|
          [e.name, e.read]
        end
      ]
    end

    attr_reader :contents

    def read(filename)
      contents.fetch(filename)
    end
  end
end
