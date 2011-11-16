require 'spec_helper'

module ElVfs

  describe Command::GetDescendants do
    let(:params)    { {} }
    let(:command)   { Command::GetDescendants.new params }
    let(:subject)   { command.result }
    let(:root)      { Entry.root }
    let(:directory) { Fabricate :directory, :parent => root }
    alias :create_directory :directory
    let(:target)    { directory.target }
    let(:subdirectory)  { Fabricate(:directory, :parent => directory)}
    alias :create_subdirectory :subdirectory
    let(:subsubdirectory)  { Fabricate(:directory, :parent => subdirectory)}
    alias :create_subsubdirectory :subsubdirectory

    describe 'target: root' do
      before { create_directory }
      let(:params)    { {target: root.target } }
      its(:tree) { should == [directory] }

      describe 'with directories at 2 level' do
        before {  create_subdirectory }
        its(:tree) { should == [directory, subdirectory] }

        describe 'with directories at 3 level' do
          before { create_subsubdirectory }
          its(:tree) { should == [directory, subdirectory] }
        end
      end
    end

    describe 'target: directory' do
      let(:params)    { {target: directory.target} }

      its(:tree) { should == [] }

      describe 'with directories at 2 level' do
        before { create_subdirectory }

        its(:tree) { should == [subdirectory] }

        describe 'with directories at 3 level' do
          before { create_subsubdirectory }

          its(:tree) { should == [subdirectory, subsubdirectory] }
        end
      end
    end

    describe "without target" do
      its(:error) { should == [:errCmdParams, :tree] }
    end

    describe 'wrong: params, target: target' do
      let(:params) { {wrong: 'params', target: target} }

      its(:error) { should == [:errCmdParams, :tree] }
    end
  end

end
