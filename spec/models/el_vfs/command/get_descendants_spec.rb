require 'spec_helper'

module ElVfs

  describe Command::GetDescendants do
    let(:params)            { {} }
    let(:command)           { described_class.new params }
    let(:result)            { command.result }
    let(:root)              { Entry.root }
    let(:directory)         { Fabricate :directory, :parent => root }
    let(:target)            { directory.target }
    let(:subdirectory)      { Fabricate(:directory, :parent => directory)}
    let(:subsubdirectory)   { Fabricate(:directory, :parent => subdirectory)}

    alias :create_directory :directory
    alias :create_subdirectory :subdirectory
    alias :create_subsubdirectory :subsubdirectory

    before                  { command.run }

    let(:subject)           { result }

    describe 'target: root' do
      before                { create_directory }
      let(:params)          { {target: root.target } }

      its(:tree)            { should == [directory] }

      describe 'with directories at 2 level' do
        before              { create_subdirectory }

        its(:tree)          { should == [directory, subdirectory] }

        describe 'with directories at 3 level' do
          before            { create_subsubdirectory }

          its(:tree)        { should == [directory, subdirectory] }
        end
      end
    end

    describe 'target: directory' do
      let(:params)          { {target: directory.target} }

      its(:tree)            { should == [] }

      describe 'with directories at 2 level' do
        before              { create_subdirectory }

        its(:tree)          { should == [subdirectory] }

        describe 'with directories at 3 level' do
          before            { create_subsubdirectory }

          its(:tree)        { should == [subdirectory, subsubdirectory] }
        end
      end
    end

  end
end
