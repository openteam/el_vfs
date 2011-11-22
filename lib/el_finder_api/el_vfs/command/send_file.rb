module ElVfs
  class Command::SendFile < Command
    register_in_connector :file

    class Arguments < Command::Arguments
      attr_accessor :target
      validates_presence_of :target
      validates :entry, :is_a_file => true
    end

    def run
      self.headers['Location'] = arguments.entry.url
    end
  end
end
