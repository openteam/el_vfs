class ElVfs::Command::Ping < ElVfs::Command
  register_in_connector

  def headers
    { 'Conncetion' => 'close' }
  end

  def result
    if argument_error
      OpenStruct.new wrong_params_hash
    else
      ''
    end
  end
end
