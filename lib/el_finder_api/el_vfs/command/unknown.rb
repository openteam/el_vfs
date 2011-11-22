module ElVfs
  class Command::Unknown < Command
    register_in_connector

    class Arguments < Command::Arguments
    end

    class Result < Command::Result
      def error
        :errUnknownCmd
      end
    end
  end
end
