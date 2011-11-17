# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::CreateDirectory do
    let(:params)    { {} }
    let(:command)   { Command::CreateDirectory.new params }
    let(:subject)   { command.result }
    let(:root)      { Entry.root }
    let(:target)    { root.target }

    describe 'target: root' do
      let(:params)  { {target: target, name: 'directory'} }
      its(:added)   { should == [root.directories.first] }
      it            { expect{command.result}.to change{root.directories.count}.by(1) }
    end

    describe "without target" do
      its(:error) { should == [:errCmdParams, :mkdir] }
    end

    describe 'wrong: params, target: target' do
      let(:params) { {wrong: 'params', target: target} }
      its(:error) { should == [:errCmdParams, :mkdir] }
    end
  end

end
