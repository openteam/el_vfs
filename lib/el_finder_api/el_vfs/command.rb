module ElVfs

  class ::IsADirectoryValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << "must be an instance of ElVfs::Directory (was #{value.class})" unless value.is_a?(ElVfs::Directory) || value.is_a?(ElVfs::Root)
    end
  end

  class ::IsAEntryValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << "must be an instance of ElVfs::Entry (was #{value.class})" unless value.is_a?(ElVfs::Entry)
    end
  end

  class Command < Model

    attr_accessor :arguments, :error, :result

    class Arguments < Model
      def entry
        @entry ||= Entry.find_by_entry_path_hash target
      end
    end

    class Result < Model
      attr_accessor :arguments, :execute_command

      def el_hash
        self.class.methods.delete_if{|m| m =~ /arguments/ || m =~ /result/ || m == 'el_hash'}.inject({}) do | method, el_hash |
          el_hash[method] = self.send(method)
          el_hash
        end
      end
    end

    class_attribute :command_name

    class Error < Model
      attr_accessor :error
    end

    def initialize(init_params)
      self.arguments = "#{self.class.name}::Arguments".constantize.new(init_params)
    end

    def result
      @result ||= "#{self.class.name}::Result".constantize.new(:arguments => arguments, :execute_command => execute_command)
    end

    alias :run :result

    protected

      def execute_command
      end

      def self.register_in_connector(command_name=nil)
        self.command_name = command_name || name.demodulize.underscore
        Connector.commands[self.command_name] = self
      end
  end
end
