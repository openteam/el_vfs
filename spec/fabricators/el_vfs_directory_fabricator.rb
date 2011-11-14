Fabricator(:directory, :from => ElVfs::Directory) do
  name 'directory'
  parent { ElVfs::Directory.root }
end
