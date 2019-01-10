require "giff/gem_file"

module Giff
  class Diff
    def initialize(file_a, file_b)
      @gem_a = to_file(file_a)
      @gem_b = to_file(file_b)
    end

    def describe
      if files_changed?
        data_a = @gem_a.data.contents
        data_b = @gem_b.data.contents
        keys = (data_a.keys + data_b.keys).sort.uniq
        keys.each do |key|
          if !data_a.key?(key)
            STDERR.puts "#{key} was removed"
          elsif !data_b.key?(key)
            STDERR.puts "#{key} was added"
          elsif data_a[key] != data_b[key]
            STDERR.puts "#{key} was modified"
          end
        end
      elsif metadata_changed?
        STDERR.puts "files equal but metadata changed"
      else
        STDERR.puts "files and metadata equal"
      end
    end

    def files_changed?
      @gem_a.data.contents != @gem_b.data.contents
    end

    def metadata_changed?
      @gem_a.metadata != @gem_b.metadata
    end

    private

    def to_file(file)
      file = File.open(file) if file.is_a?(String)

      if file.respond_to?(:read) # probably a file or IO
        Giff::GemFile.new(file)
      else
        raise ArgumentError, "#{file.inspect} isn't a file"
      end
    end
  end
end
