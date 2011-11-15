Fabricator(:file, :from => ElVfs::File) do
  file_name 'file.txt'
  parent { Fabricate :directory }
end
