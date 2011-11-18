# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::DuplicateEntries do
    let(:valid_params)      { {targets: targets} }
    let(:params)            { valid_params }
    let(:directory)         { Fabricate :directory, :parent => root }
    let(:file)              { Fabricate :file, :parent => root }
    let(:nested_file)       { Fabricate :file, :parent => directory }
    let(:entries)           { [nested_file.parent, file] }
    alias :create_entries :entries
    let(:targets)           { entries.map(&:target) }
    let(:command)           { Command::DuplicateEntries.new params }
    let(:subject)           { command.result }
    let(:root)              { Entry.root }
    let(:added_entry_names) { subject.added.map(&:entry_name) }

    describe 'default parameters' do
      it                    { added_entry_names.should == ['directory copy1', 'file copy1.txt'] }

      describe 'if copies already exists' do
        before { Fabricate(:file, :parent => root, :entry_name => 'file copy1.txt') }
        before { Fabricate(:directory, :parent => root, :entry_name => 'directory copy1') }

        it                  { added_entry_names.should == ['directory copy2', 'file copy2.txt']}
      end

      describe 'execute command' do
        before          { create_entries }

        it              { expect{command.result}.to change{root.children.count}.by(2) }
      end
    end

    describe "without targets" do
      let(:params)      { valid_params.delete :targets; valid_params }
      its(:error)       { should == [:errCmdParams, :duplicate] }
    end

    describe 'wrong: params' do
      let(:params)      { valid_params[:wrong]='params'; valid_params }
      its(:error)       { should == [:errCmdParams, :duplicate] }
    end
  end

end
