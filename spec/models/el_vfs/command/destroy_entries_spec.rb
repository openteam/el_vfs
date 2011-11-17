# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::DestroyEntries do
    let(:valid_params)  { {targets: targets} }
    let(:params)        { valid_params }
    let(:file)          { Fabricate :file, :parent => root }
    let(:directory)     { Fabricate :directory, :parent => root }
    let(:entries)       { [file, directory] }
    alias :create_entries :entries
    let(:targets)       { entries.map(&:target) }
    let(:command)       { Command::DestroyEntries.new params }
    let(:subject)       { command.result }
    let(:root)          { Entry.root }

    describe 'default parameters' do
      its(:removed)     { should == [file, directory] }

      describe 'execute command' do
        before          { create_entries }

        it              { expect{command.result}.to change{root.children.count}.by(-2) }
        it              { command.result; expect{entries.map(&:reload)}.should raise_error ActiveRecord::RecordNotFound }
      end
    end

    describe "without targets" do
      let(:params)      { {} }
      its(:error)       { should == [:errCmdParams, :rm] }
    end

    describe 'wrong: params' do
      let(:params)      { valid_params[:wrong]='params'; valid_params }
      its(:error)       { should == [:errCmdParams, :rm] }
    end
  end

end
