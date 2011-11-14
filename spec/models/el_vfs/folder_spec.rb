require 'spec_helper'

describe ElVfs::Folder do
  it { should validate_presence_of :name }
end
