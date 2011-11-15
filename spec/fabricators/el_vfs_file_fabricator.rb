Fabricator(:file, :from => ElVfs::File) do
  entry   { File.new("#{SPEC_ROOT}/fixtures/file.txt") }
  parent  { Fabricate :directory }
end
