require 'spec_helper'

module ElVfs

  describe Command::GetAncestors do
    let(:params)          { {} }
    let(:command)         { Command::GetAncestors.new params }
    let(:subject)         { command.result }
    let(:root)            { Entry.root }
    let(:directory)       { Fabricate :directory, :parent => root }
    let(:target)          { directory.target }
    let(:subdirectory)    { Fabricate(:directory, :parent => directory)}
    let(:subsubdirectory) { Fabricate(:directory, :parent => subdirectory)}
    alias :create_directory :directory
    alias :create_subdirectory :subdirectory
    alias :create_subsubdirectory :subsubdirectory

    describe 'target: root' do
      let(:params)  { {target: root.target } }
      its(:tree)    { should == [] }
    end

    describe 'target: directory' do
      let(:params)  { {target: directory.target } }
      its(:tree)    { should == [root] }
    end

    describe 'target: subdirectory' do
      let(:params)  { {target: subdirectory.target } }
      its(:tree)    { should == [root, directory] }
    end

    describe 'target: subsubdirectory' do
      let(:params)  { {target: subsubdirectory.target } }
      its(:tree)    { should == [root, directory, subdirectory] }
    end

    describe "without target" do
      its(:error) { should == [:errCmdParams, :parents] }
    end

    describe 'wrong: params, target: target' do
      let(:params) { {wrong: 'params', target: target} }

      its(:error) { should == [:errCmdParams, :parents] }
    end
  end

end
