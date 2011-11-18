module ElVfs
  class ElVfs::Command::UpdateFileBody < ElVfs::Command
    register_in_connector :put

    options :target, :content

    protected

      def hash
        if target && file && content
          { :added => update_file_body }
        else
          wrong_params_hash
        end
      end

    private

      def update_file_body
        Dir.mktmpdir do |dir|
          content_file =  ::File.open("#{dir}/#{file.entry_name}", "w"){|f|f.write(content)}
          file.entry = ::File.open("#{dir}/#{file.entry_name}")
        end
        file
      end

  end
end
