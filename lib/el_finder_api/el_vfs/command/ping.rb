module ElVfs
  class Command::Ping < Command
    register_in_connector

    class Arguments < Command::Arguments
    end

    def run
      self.headers['Connection'] = 'close'
    end
  end
end
