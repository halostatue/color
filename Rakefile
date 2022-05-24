# frozen_string_literal: true

require "rubygems"
require "hoe"
require "rake/clean"

# This is required until https://github.com/seattlerb/hoe/issues/112 is fixed
class Hoe
  def with_config
    config = Hoe::DEFAULT_CONFIG

    rc = File.expand_path("~/.hoerc")
    homeconfig = load_config(rc)
    config = config.merge(homeconfig)

    localconfig = load_config(File.expand_path(File.join(Dir.pwd, ".hoerc")))
    config = config.merge(localconfig)

    yield config, rc
  end

  def load_config(name)
    File.exist?(name) ? safe_load_yaml(name) : {}
  end

  def safe_load_yaml(name)
    return safe_load_yaml_file(name) if YAML.respond_to?(:safe_load_file)

    data = IO.binread(name)
    YAML.safe_load(data, permitted_classes: [Regexp])
  rescue
    YAML.safe_load(data, [Regexp])
  end

  def safe_load_yaml_file(name)
    YAML.safe_load_file(name, permitted_classes: [Regexp])
  rescue
    YAML.safe_load_file(name, [Regexp])
  end
end

Hoe.plugin :doofus
Hoe.plugin :gemspec2
Hoe.plugin :git
Hoe.plugin :minitest
Hoe.plugin :email unless ENV["CI"]

spec = Hoe.spec "color" do
  developer("Austin Ziegler", "halostatue@gmail.com")
  developer("Matt Lyon", "matt@postsomnia.com")

  require_ruby_version ">= 2.7"

  self.history_file = "History.md"
  self.readme_file = "README.rdoc"

  license "MIT"

  extra_dev_deps << ["hoe-doofus", "~> 1.0"]
  extra_dev_deps << ["hoe-gemspec2", "~> 1.1"]
  extra_dev_deps << ["hoe-git", "~> 1.6"]
  extra_dev_deps << ["hoe-rubygems", "~> 1.0"]
  extra_dev_deps << ["minitest", "~> 5.8"]
  extra_dev_deps << ["minitest-around", "~> 0.3"]
  extra_dev_deps << ["minitest-autotest", "~> 1.0"]
  extra_dev_deps << ["minitest-bisect", "~> 1.2"]
  extra_dev_deps << ["minitest-focus", "~> 1.1"]
  extra_dev_deps << ["minitest-moar", "~> 0.0"]
  extra_dev_deps << ["minitest-pretty_diff", "~> 0.1"]
  extra_dev_deps << ["rake", ">= 10.0", "< 14.0"]
  extra_dev_deps << ["standard", "~> 1.0"]
  extra_dev_deps << ["simplecov", "~> 0.7"]
end

namespace :test do
  desc "Run test coverage"
  task :coverage do
    spec.test_prelude = [
      'require "simplecov"',
      'SimpleCov.start("test_frameworks") { command_name "Minitest" }',
      'gem "minitest"'
    ].join("; ")
    Rake::Task["test"].execute
  end
end
