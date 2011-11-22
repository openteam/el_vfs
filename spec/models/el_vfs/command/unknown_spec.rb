require 'spec_helper'

describe ElVfs::Command::Unknown do
  let(:command) { described_class.new({}) }
  let(:subject) { command.result }
  before        { command.run }
  its(:error)   { should == :errUnknownCmd }
end
