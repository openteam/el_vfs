# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::CreateFile do
    let(:params)    { {} }
    let(:command)   { Command::CreateFile.new params }
    let(:subject)   { command.result }
    let(:root)      { Entry.root }
    let(:target)    { root.target }

    before          { command.run }

    describe 'target: root' do
      let(:params)  { {target: target, name: 'file'} }
      its(:added)   { should == [root.files.first] }
      it            { expect{command.result.added}.to change{root.files.count}.by(1) }
    end
  end

end
