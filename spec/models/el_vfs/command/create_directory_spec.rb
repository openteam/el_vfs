# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::CreateDirectory do
    let(:params)      { {} }
    let(:command)     { Command::CreateDirectory.new params }
    let(:root)        { Entry.root }


    describe 'target: root' do
      let(:params)    { {target: root.target, name: 'directory'} }
      it              { expect{command.run; command.result.el_hash}.to change{root.directories.count}.by(1) }

      describe 'result' do
        before        { command.run }
        let(:subject) { command.result }

        its(:added)   { should == [root.directories.first] }
      end
    end
  end

end
