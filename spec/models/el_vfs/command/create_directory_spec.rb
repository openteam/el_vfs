# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::CreateDirectory do
    let(:params)      { {target: root.target, name: 'directory'} }
    let(:command)     { described_class.new params }
    let(:root)        { Entry.root }

    describe 'target: root' do
      it              { expect{command.send(:execute_command)}.to change{root.directories.count}.by(1) }

      describe 'result' do
        let(:subject) { command.result }
        before        { command.run }
        its(:added)   { should == [root.directories.first] }
      end
    end
  end

end
