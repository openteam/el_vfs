class ElVfs::Command::SendFile < ElVfs::Command
  register_in_connector :file

  options :target

  def result
    if target && file
      file.entry.data
    else
      OpenStruct.new hash
    end
  end

end
