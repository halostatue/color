#! /usr/bin/env rake
#--
# Color
# Colour Management with Ruby
# http://rubyforge.org/projects/color
#
# Licensed under a MIT-style licence. See Licence.txt in the main
# distribution for full licensing information.
#
# Copyright (c) 2005 - 2010 Austin Ziegler and Matt Lyon
#++

require 'rubygems'
require 'hoe'

$LOAD_PATH.unshift('lib')

require 'color'

PKG_NAME    = 'color'
PKG_VERSION = Color::COLOR_VERSION
PKG_DIST    = "#{PKG_NAME}-#{PKG_VERSION}"
PKG_TAR     = "pkg/#{PKG_DIST}.tar.gz"
MANIFEST    = File.read("Manifest.txt").split

Hoe.spec PKG_NAME do
  self.version = PKG_VERSION

# self.rubyforge_name = PKG_NAME

  developer "Austin Ziegler", "austin@rubyforge.org" 
  developer "Matt Lyon", "matt@postsomnia.com" 

  self.url = %W(http://color.rubyforge.org/ http://github.com/halostatue/color)

  self.summary = "Colour management with Ruby"
  self.changes = paragraphs_of("History.txt", 0..1).join("\n\n")
  self.description = paragraphs_of("README.txt", 1..1).join("\n\n")

  extra_dev_deps << [ "archive-tar-minitar", "~>0.5.1" ]
  clean_globs << "coverage"

  spec_extras[:required_ruby_version] = ">= 1.8.7"

  # This is a lie because I will continue to use Archive::Tar::Minitar.
  self.need_tar        = false
end

desc "Build a Color .tar.gz distribution."
task :tar => [ PKG_TAR ]
file PKG_TAR => [ :test ] do |t|
  require 'archive/tar/minitar'
  require 'zlib'
  files = MANIFEST.map { |f|
    fn = File.join(PKG_DIST, f)
    tm = File.stat(f).mtime

    if File.directory?(f)
      { :name => fn, :mode => 0755, :dir => true, :mtime => tm }
    else
      mode = if f =~ %r{^bin}
               0755
             else
               0644
             end
      data = File.read(f)
      { :name => fn, :mode => mode, :data => data, :size => data.size,
        :mtime => tm }
    end
  }

  begin
    unless File.directory?(File.dirname(t.name))
      require 'fileutils'
      File.mkdir_p File.dirname(t.name)
    end
    tf = File.open(t.name, 'wb')
    gz = Zlib::GzipWriter.new(tf)
    tw = Archive::Tar::Minitar::Writer.new(gz)

    files.each do |entry|
      if entry[:dir]
        tw.mkdir(entry[:name], entry)
      else
        tw.add_file_simple(entry[:name], entry) { |os|
          os.write(entry[:data])
        }
      end
    end
  ensure
    tw.close if tw
    gz.close if gz
  end
end
task :package => [ PKG_TAR ]

desc "Build the manifest file from the current set of files."
task :build_manifest do |t|
  require 'find'

  paths = []
  Find.find(".") do |path|
    next if File.directory?(path)
    next if path =~ /\.svn/
    next if path =~ /\.git/
    next if path =~ /\.hoerc/
    next if path =~ /\.swp$/
    next if path =~ %r{coverage/}
    next if path =~ /~$/
    paths << path.sub(%r{^\./}, '')
  end

  File.open("Manifest.txt", "w") do |f|
    f.puts paths.sort.join("\n")
  end

  puts paths.sort.join("\n")
end
