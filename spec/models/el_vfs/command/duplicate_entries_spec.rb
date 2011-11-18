# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::DuplicateEntries do
    let(:valid_params)  { {targets: targets} }
    let(:params)        { valid_params }
    let(:directory)     { Fabricate :directory, :parent => root }
    let(:file)          { Fabricate :file, :parent => root }
    let(:entries)       { [directory, file] }
    alias :create_entries :entries
    let(:targets)       { entries.map(&:target) }
    let(:command)       { Command::DuplicateEntries.new params }
    let(:subject)       { command.result }
    let(:root)          { Entry.root }

    its(:added)         { subject.map(&:entry_name).should == ['directory copy1', 'file copy1.txt'] }
    it                  { create_entries; expect{command.result}.to change{root.children.count}.by(2) }

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
