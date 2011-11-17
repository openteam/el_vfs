require 'spec_helper'

module ElVfs

  describe Command::RenameEntry do
    let(:target)    { entry.target }
    let(:params)    { {target: target, :name => 'new_name'} }
    let(:directory) { Fabricate :directory }
    let(:file)      { Fabricate :file }
    let(:command)   { Command::RenameEntry.new params }
    let(:subject)   { command.result }
    let(:root)      { Entry.root }
    alias :entry :root

    describe 'target: directory' do
      alias :entry :directory

      its(:added)   { should == [directory.reload] }
      its(:removed) { should == [target] }
    end

    describe 'target: file' do
      alias :entry :file

      its(:added)   { should == [file.reload] }
      its(:removed) { should == [target] }
    end

    describe "without target" do
      let(:params)  { {:name => 'new_name'} }
      its(:error)   { should == [:errCmdParams, :rename] }
    end

    describe "without name" do
      let(:params)  { {:target => directory} }
      its(:error)   { should == [:errCmdParams, :rename] }
    end

    describe 'wrong: params, target: target' do
      let(:params)  { {wrong: 'params', target: directory.target} }

      its(:error)   { should == [:errCmdParams, :rename] }
    end
  end

end
