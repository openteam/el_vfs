require 'spec_helper'

describe ElVfs::Directory do
  it { should validate_presence_of :name }
end
