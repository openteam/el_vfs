# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::CreateFile do
    let(:params)    { {} }
    let(:command)   { Command::CreateFile.new params }
    let(:subject)   { command.result }
    let(:root)      { Entry.root }
    let(:target)    { root.target }

    describe 'target: root' do
      let(:params)  { {target: target, name: 'file'} }
      its(:added)   { should == [root.files.first] }
      it            { expect{command.result}.to change{root.files.count}.by(1) }
    end

    describe "without target" do
      its(:error) { should == [:errCmdParams, :mkfile] }
    end

    describe 'wrong: params, target: target' do
      let(:params) { {wrong: 'params', target: target} }
      its(:error) { should == [:errCmdParams, :mkfile] }
    end
  end

end
