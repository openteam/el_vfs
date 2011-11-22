module ElVfs
  class Command::UploadFiles < ElVfs::Command
    register_in_connector :upload

    class Arguments < Command::Arguments
      attr_accessor :target, :upload
      validates_presence_of :target
      validates :entry, :is_a_directory => true
    end

    class Result < Command::Result
       def added
         execute_command
       end
    end

    protected
      def execute_command
        arguments.upload.map{|file| ElVfs::File.create! :parent => arguments.entry, :entry => file}
      end
  end
end
