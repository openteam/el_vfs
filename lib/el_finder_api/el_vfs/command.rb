module ElVfs

  class Command

    class_attribute :command_name
    class_attribute :options

    def initialize(params={})
      self.class.options.each do | option |
        self.instance_variable_set "@#{option}", params[option] if params.has_key?(option)
      end
    end

    def result
      {:error => [:errCmdParams, command_name.to_sym]}
    end

    def self.options(*args)
      self.options = args
      options.each do | option |
        attr_accessor option
      end
    end

    def self.register_in_connector(command_name=nil)
      self.command_name = command_name || name.demodulize.underscore
      Connector.commands[self.command_name] = self
    end

  end

end
