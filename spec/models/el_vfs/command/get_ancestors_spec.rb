require 'spec_helper'

module ElVfs

  describe Command::GetAncestors do
    let(:params)                  { {target: current.target} }
    let(:command)                 { described_class.new params }
    let(:root)                    { Entry.root }
    let(:directory)               { Fabricate :directory, :parent => root }
    let(:another_directory)       { Fabricate :directory, :parent => root, :entry_name => 'another_directory' }
    let(:subdirectory)            { Fabricate(:directory, :parent => directory, :entry_name => 'subdirectory')}
    let(:another_subdirectory)    { Fabricate(:directory, :parent => directory, :entry_name => 'another_subdirectory')}
    let(:subsubdirectory)         { Fabricate(:directory, :parent => subdirectory, :entry_name => 'subsubdirectory')}
    let(:another_subsubdirectory) { Fabricate(:directory, :parent => subdirectory, :entry_name => 'another_subsubdirectory')}

    alias :create_directory :directory
    alias :create_subdirectory :subdirectory
    alias :create_subsubdirectory :subsubdirectory
    alias :create_another_directory :another_directory
    alias :create_another_subdirectory :another_subdirectory
    alias :create_another_subsubdirectory :another_subsubdirectory

    before                        { create_directory }
    before                        { create_another_directory }
    before                        { create_subdirectory }
    before                        { create_another_subdirectory }
    before                        { create_subsubdirectory }
    before                        { create_another_subsubdirectory }

    before                        { command.run }

    let(:subject)                 { command.result }

    describe 'target: root' do
      let(:current)               { root }
      its(:tree)                  { should == [root] }
    end

    describe 'target: directory' do
      let(:current)               { directory }
      its(:tree)                  { should == [root, directory] }
    end

    describe 'target: subdirectory' do
      let(:current)               { subdirectory }
      its(:tree)                  { should == [root, directory, subdirectory, another_subdirectory] }
    end

    describe 'target: subsubdirectory' do
      let(:current)               { subsubdirectory }
      its(:tree)                  { should == [root, directory, subdirectory, another_subdirectory, subsubdirectory, another_subsubdirectory] }
    end

  end

end
