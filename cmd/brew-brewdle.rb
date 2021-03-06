#!/usr/bin/env ruby

BREWDLER_ROOT = File.expand_path "#{File.dirname(__FILE__)}/.."
BREWDLER_LIB = Pathname.new(BREWDLER_ROOT)/"lib"

$LOAD_PATH.unshift(BREWDLER_LIB)

require "brewdler"

usage = <<-EOS.undent
  brew brewdle [-v|--verbose]
  brew brewdle dump [--force]
  brew brewdle cleanup [--dry-run]
  brew brewdle [--version]
  brew brewdle [-h|--help]

  Usage:
  Bundler for non-Ruby dependencies from Homebrew

  brew brewdle           read Brewfile and install all dependencies
  brew brewdle dump      write all currently installed packages into a Brewfile
  brew brewdle cleanup   uninstall all Homebrew formulae not listed in Brewfile

  Options:
  -v, --verbose          print verbose output
  --force                force overwrite existed Brewfile
  --dry-run              list formulae rather than actual uninstalling them
  -h, --help             show this help message and exit
  --version              show the version of brewdler
EOS

if ARGV.include?("--version")
  puts Brewdler::VERSION
  exit 0
end

if ARGV.flag?("--help")
  puts usage
  exit 0
end

case ARGV.named[0]
when nil, "install"
  Brewdler::Commands::Install.run
when "dump"
  Brewdler::Commands::Dump.run
when "cleanup"
  Brewdler::Commands::Cleanup.run
else
  abort usage
end

