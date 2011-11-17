require 'spec_helper'

describe ElVfs::Command::Unknown do
  let(:subject) { ElVfs::Command::Unknown.new({}) }
  its(:result) { should == {:error => :errUnknownCmd} }
end
