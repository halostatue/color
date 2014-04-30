# -*- ruby encoding: utf-8 -*-

require 'rubygems'
require 'hoe'

Hoe.plugin :doofus
Hoe.plugin :email
Hoe.plugin :gemspec2
Hoe.plugin :git
Hoe.plugin :minitest
Hoe.plugin :travis
Hoe.plugin :email unless ENV['CI'] or ENV['TRAVIS']

spec = Hoe.spec 'color' do
  developer('Austin Ziegler', 'halostatue@gmail.com')
  developer('Matt Lyon', 'matt@postsomnia.com')

  license 'MIT'

  self.need_tar = true

  self.history_file = 'History.rdoc'
  self.readme_file = 'README.rdoc'
  self.extra_rdoc_files = FileList["*.rdoc"].to_a

  self.extra_dev_deps << ['hoe-doofus', '~> 1.0']
  self.extra_dev_deps << ['hoe-gemspec2', '~> 1.1']
  self.extra_dev_deps << ['hoe-git', '~> 1.5']
  self.extra_dev_deps << ['hoe-rubygems', '~> 1.0']
  self.extra_dev_deps << ['hoe-travis', '~> 1.2']
  self.extra_dev_deps << ['minitest', '~> 5.0']
  self.extra_dev_deps << ['rake', '~> 10.0']

  if RUBY_VERSION >= '1.9' and (ENV['CI'] or ENV['TRAVIS'])
    self.extra_dev_deps << ['simplecov', '~> 0.7']
    self.extra_dev_deps << ['coveralls', '~> 0.7']
  end
end

if RUBY_VERSION >= '1.9'
  namespace :test do
    desc "Submit test coverage to Coveralls"
    task :coveralls do
      spec.test_prelude = [
        'require "psych"',
        'require "simplecov"',
        'require "coveralls"',
        'SimpleCov.formatter = Coveralls::SimpleCov::Formatter',
      ].join('; ')
      Rake::Task['test'].execute
    end

    desc "Runs test coverage. Only works Ruby 1.9+ and assumes 'simplecov' is installed."
    task :coverage do
      spec.test_prelude = [
        'require "simplecov"',
        'SimpleCov.start("test_frameworks") { command_name "Minitest" }',
        'gem "minitest"'
      ].join('; ')
      Rake::Task['test'].execute
    end
  end

  Rake::Task['travis'].prerequisites.replace(%w(test:coveralls))
end
