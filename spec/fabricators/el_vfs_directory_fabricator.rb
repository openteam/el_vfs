Fabricator(:directory, :from => ElVfs::Directory) do
  file_name 'directory'
  parent { ElVfs::Directory.root }
end
