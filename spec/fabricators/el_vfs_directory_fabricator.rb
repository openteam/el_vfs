Fabricator(:directory, :from => ElVfs::Directory) do
  entry_name 'directory'
  parent { ElVfs::Entry.root }
end
