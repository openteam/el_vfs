require 'ostruct'

module ElVfs

  class Command

    class_attribute :command_name
    class_attribute :options

    attr_accessor :argument_error, :parameters

    def initialize(parameters)
      self.parameters = parameters.with_indifferent_access
      validate_parameter_keys
      self.class.options.each do | option |
        self.instance_variable_set "@#{option}", self.parameters[option]
      end unless argument_error
    end

    def headers
      {}
    end

    def result
      if argument_error
        OpenStruct.new wrong_params_hash
      else
        OpenStruct.new hash
      end
    end

    protected

      def directory
        @directory ||= Entry.only_directories.find_by_entry_path_hash target
      end

      def file
        @file ||= Entry.only_files.find_by_entry_path_hash target
      end

      def entry
        @entry ||= Entry.find_by_entry_path_hash target
      end

      def wrong_params_hash
        {:error => [:errCmdParams, command_name.to_sym]}
      end

      def self.options(*args)
        self.options = args.map(&:to_s)
        options.each do | option |
          attr_accessor option
        end
      end

      def self.register_in_connector(command_name=nil)
        self.command_name = command_name || name.demodulize.underscore
        Connector.commands[self.command_name] = self
      end

    private

      def validate_parameter_keys
        self.argument_error = (parameters.keys - self.class.options).any?
      end

  end
end
