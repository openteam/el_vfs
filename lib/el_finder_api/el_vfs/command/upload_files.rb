module ElVfs
  class Command::UploadFiles < ElVfs::Command
    register_in_connector :upload
    options :target, :upload

    alias :uploaded_files :upload

    protected
      def hash
        if target && uploaded_files.is_a?(Array) && uploaded_files.any?
          { added: upload_files }
        else
          wrong_params_hash
        end
      end

    private
      def upload_files
        uploaded_files.map{|file| File.create :parent => directory, :entry => file}
      end
  end
end
