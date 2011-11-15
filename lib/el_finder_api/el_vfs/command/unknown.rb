class ElVfs::Command::Unknown < ElVfs::Command
  register_in_connector

  def result
    { :error => :errUnknownCmd }
  end
end
