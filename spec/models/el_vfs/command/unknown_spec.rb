require 'spec_helper'

describe ElVfs::Command::Unknown do
  its(:result) { should == {:error => :errUnknownCmd} }
end
