require 'spec_helper'

describe Vfs::File do
  it { should validate_presence_of :name }
end
