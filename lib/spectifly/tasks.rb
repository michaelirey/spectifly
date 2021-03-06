require 'rake'
require 'rake/tasklib'
require 'yaml'
require 'spectifly/configuration'

module Spectifly
  class Task < ::Rake::TaskLib
    attr_accessor :configuration

    def configure!
      config_path = File.join(Rake.original_dir, 'config', 'spectifly.yml')
      config_hash = File.exist?(config_path) ? YAML.load_file(config_path) : {}
      @configuration = Spectifly::Configuration.new(config_hash)
    end

    def initialize(task_name, *args, &block)
      configure!
      task task_name, *args do |task_name, task_args|
        block.call(configuration, task_args) if block
      end
    end
  end
end

Dir[File.join(File.dirname(__FILE__), '..', 'tasks', '*.rake')].each do |path|
  load path
end