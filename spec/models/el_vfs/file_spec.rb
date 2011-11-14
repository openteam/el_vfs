require 'spec_helper'

describe ElVfs::File do
  it { should validate_presence_of :name }
end
