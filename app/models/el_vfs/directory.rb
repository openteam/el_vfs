module ElVfs
  class Directory < Entry
    default_values :entry_mime_type => 'directory', :entry_size => 0
  end
end
