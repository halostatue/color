# -*- ruby encoding: utf-8 -*-

require 'rubygems'
require 'hoe'

Hoe.plugin :doofus
Hoe.plugin :email
Hoe.plugin :gemspec2
Hoe.plugin :git
Hoe.plugin :minitest
Hoe.plugin :rubyforge
Hoe.plugin :travis

spec = Hoe.spec 'color' do
  developer('Austin Ziegler', 'austin@rubyforge.org')
  developer('Matt Lyon', 'matt@postsomnia.com')

  self.need_tar = true

  # self.require_ruby_version '>= 1.9.2'

  self.remote_rdoc_dir = '.'
  self.rsync_args << ' --exclude=statsvn/'

  self.history_file = 'History.rdoc'
  self.readme_file = 'README.rdoc'
  self.extra_rdoc_files = FileList["*.rdoc"].to_a
  self.licenses = ["MIT"]

  self.extra_dev_deps << ['hoe-doofus', '~> 1.0']
  self.extra_dev_deps << ['hoe-gemspec2', '~> 1.1']
  self.extra_dev_deps << ['hoe-git', '~> 1.5']
  self.extra_dev_deps << ['hoe-rubygems', '~> 1.0']
  self.extra_dev_deps << ['hoe-travis', '~> 1.2']
  self.extra_dev_deps << ['minitest', '~> 5.0']
  self.extra_dev_deps << ['rake', '~> 10.0']
  self.extra_dev_deps << ['simplecov', '~> 0.7']
end

namespace :test do
  task :coverage do
    spec.test_prelude = [
      'require "simplecov"',
      'SimpleCov.start("test_frameworks") { command_name "Minitest" }',
      'gem "minitest"'
    ].join('; ')
    Rake::Task['test'].execute
  end
end
