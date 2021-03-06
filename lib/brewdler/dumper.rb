require "fileutils"
require "pathname"

module Brewdler
  class Dumper
    attr_reader :brew, :cask, :repo

    def initialize
      @brew = BrewDumper.new
      @cask = CaskDumper.new
      @repo = RepoDumper.new
    end

    def dump_brewfile
      content = [repo, brew, cask].map(&:to_s).reject(&:empty?).join("\n") + "\n"
      write_file Pathname.new(Dir.pwd).join("Brewfile"), content, ARGV.force?
    end

    private

    def write_file(file, content, overwrite=false)
      if file.exist?
        if overwrite && file.file?
          FileUtils.rm file
        else
          raise "#{file} already existed."
        end
      end
      file.write content
    end
  end
end
