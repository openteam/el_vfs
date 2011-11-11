require 'spec_helper'

describe Vfs::Folder do
  it { should validate_presence_of :name }
end
