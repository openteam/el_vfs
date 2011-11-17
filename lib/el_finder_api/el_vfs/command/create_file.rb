module ElVfs
  class Command::CreateFile < ElVfs::Command
    register_in_connector :mkfile
    options :target, :name

    protected
      def hash
        if target && name
          { added: [ create_empty_file ] }
        else
          wrong_params_hash
        end
      end

    private

      def create_empty_file
        File.new(:parent => directory).tap do | file |
          Dir.mktmpdir{|dir| file.entry = ::File.open("#{dir}/#{name}", "w") }
          file.save!
        end
      end
  end
end
