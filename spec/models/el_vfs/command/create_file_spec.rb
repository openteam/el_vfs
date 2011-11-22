# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::CreateFile do
    let(:params)      { {target: root.target, name: 'file'} }
    let(:command)     { described_class.new params }
    let(:root)        { Entry.root }

    describe 'target: root' do
      it              { expect{command.run}.to change{root.files.count}.by(1) }

      describe 'result' do
        let(:subject) { command.result }
        before        { command.run }

        its(:added)   { should == [root.files.first] }
      end
    end
  end

end
