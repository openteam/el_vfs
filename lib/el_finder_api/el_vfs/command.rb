require 'ostruct'

module ElVfs

  class Command

    class_attribute :command_name
    class_attribute :options

    def initialize(params={})
      params = params.with_indifferent_access
      self.class.options.each do | option |
        self.instance_variable_set "@#{option}", params[option]
      end unless wrong?(params.keys)
    end

    def result
      OpenStruct.new hash
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

    protected
      def directory
        @directory ||= Entry.only_directories.find_by_entry_path_hash target
      end

      def hash
        {:error => [:errCmdParams, command_name.to_sym]}
      end

      alias :wrong_params_hash :hash

    private

      def wrong?(options)
        (options - self.class.options).any?
      end

  end
end
