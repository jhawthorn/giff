require "giff/gem_file"

module Giff
  class Diff
    def initialize(file_a, file_b)
      @gem_a = to_file(file_a)
      @gem_b = to_file(file_b)
    end

    def describe
      data_a = @gem_a.data
      data_b = @gem_b.data
      if data_a.contents == data_b.contents
        STDERR.puts "files are equal"
      else
        keys = (data_a.keys + data_b.keys).sort.uniq
        keys.each do |key|
          if !data_a.key?(key)
            STDERR.puts "#{key} was removed"
          elsif !data_b.key?(key)
            STDERR.puts "#{key} was added"
          elsif data_a[key] != data_b[key]
            STDERR.puts "#{key} was modified"
          else
            STDERR.puts "#{key} was unchanged"
          end
        end
      end
    end

    private

    def to_file(file)
      file = File.open(file) if file.is_a?(String)

      if file.is_a?(File)
        Giff::GemFile.new(file)
      else
        raise ArgumentError, "#{file.inspect} isn't a file"
      end
    end
  end
end
