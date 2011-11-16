require 'spec_helper'

module ElVfs

  describe Command::ChangeWorkingDirectory do
    let(:params)    { {} }
    let(:command)   { Command::ChangeWorkingDirectory.new params }
    let(:subject)   { command.result }
    let(:root)      { Entry.root }
    alias :directory :root
    let(:target)    { directory.entry_uid_hash }
    let(:file)      { Fabricate :file, :parent => directory }
    alias :create_file :file

    before { create_file }

    its(:error) { should == [:errCmdParams, :open] }


    describe 'init: true' do
      let(:params) { {init: true} }

      its(:api)     { should == 2 }
      its(:cwd)     { should == directory.el_hash }
      its(:files)   { should == [file.el_hash] }
      its(:options) { should == [] }

      describe 'target: directory' do
        let(:params) { {init: true, target: target} }
        let(:directory) { Fabricate(:directory) }

        its(:api) { should == 2}
        its(:cwd) { should == directory.el_hash }
        its(:files)   { should == [file.el_hash] }
        its(:options) { should == [] }

        describe 'tree: true' do
          let(:params) { {init: true, target: target, tree: true} }
          before { Fabricate(:file, :parent => root )}

          its(:api)     { should == 2}
          its(:cwd)     { should == directory.el_hash }
          its(:files)   { should == [file, root, directory].map(&:el_hash) }
        end
      end
    end

    describe 'target: directory' do
      let(:directory) { Fabricate :directory }
      let(:params)    { {target: target} }

      its(:cwd) { should == directory.el_hash }
    end

    describe 'wrong: params, target: target' do
      let(:params) { {wrong: 'params', target: target} }

      its(:error) { should == [:errCmdParams, :open] }
    end
  end

end
