require "rubygems"
require "hoe"
require "rake/clean"
require "rdoc/task"
require "minitest"
require "minitest/test_task"

Hoe.plugin :halostatue
Hoe.plugin :rubygems

Hoe.plugins.delete :debug
Hoe.plugins.delete :newb
Hoe.plugins.delete :publish
Hoe.plugins.delete :signing
Hoe.plugins.delete :test

hoe = Hoe.spec "color" do
  developer("Austin Ziegler", "halostatue@gmail.com")
  developer("Matt Lyon", "matt@postsomnia.com")

  self.trusted_release = ENV["rubygems_release_gem"] == "true"

  require_ruby_version ">= 3.2"

  license "MIT"

  spec_extras[:metadata] = ->(val) {
    val.merge!({"rubygems_mfa_required" => "true"})
  }

  extra_dev_deps << ["hoe", "~> 4.0"]
  extra_dev_deps << ["hoe-halostatue", "~> 2.1", ">= 2.1.1"]
  extra_dev_deps << ["hoe-doofus", "~> 1.0"]
  extra_dev_deps << ["hoe-rubygems", "~> 1.0"]
  extra_dev_deps << ["hoe-gemspec2", "~> 1.4"]
  extra_dev_deps << ["hoe-git", "~> 1.6"]
  extra_dev_deps << ["minitest", "~> 5.8"]
  extra_dev_deps << ["minitest-autotest", "~> 1.0"]
  extra_dev_deps << ["minitest-focus", "~> 1.1"]
  extra_dev_deps << ["minitest-moar", "~> 0.0"]
  extra_dev_deps << ["rake", ">= 10.0", "< 14"]
  extra_dev_deps << ["rdoc", ">= 0.0"]
  extra_dev_deps << ["standard", "~> 1.0"]
  extra_dev_deps << ["json", ">= 0.0"]
end

Minitest::TestTask.create :test
Minitest::TestTask.create :coverage do |t|
  formatters = <<-RUBY.split($/).join(" ")
    SimpleCov::Formatter::MultiFormatter.new([
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::LcovFormatter,
      SimpleCov::Formatter::SimpleFormatter
    ])
  RUBY
  t.test_prelude = <<-RUBY.split($/).join("; ")
  require "simplecov"
  require "simplecov-lcov"

  SimpleCov::Formatter::LcovFormatter.config do |config|
    config.report_with_single_file = true
    config.lcov_file_name = "lcov.info"
  end

  SimpleCov.start "test_frameworks" do
    enable_coverage :branch
    primary_coverage :branch
    formatter #{formatters}
  end
  RUBY
end

task default: :test

task :version do
  require "color/version"
  puts Color::VERSION
end

RDoc::Task.new do
  _1.title = "Color -- Color Math with Ruby"
  _1.main = "lib/color.rb"
  _1.rdoc_dir = "doc"
  _1.rdoc_files = hoe.spec.require_paths - ["Manifest.txt"] + hoe.spec.extra_rdoc_files
  _1.markup = "markdown"
end

task docs: :rerdoc
