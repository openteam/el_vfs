require 'spec_helper'

module ElVfs

  describe Command::ChangeWorkingDirectory do
    let(:params)    { {} }
    let(:command)   { Command::ChangeWorkingDirectory.new params }
    let(:root)      { Entry.root }
    let(:directory) { Fabricate :directory, :parent => root }
    let(:target)    { directory.target }
    let(:result)    { command.result }
    let(:subject)   { result }
    let(:file)      { Fabricate(:file, :parent => root)}
    alias :create_file :file

    before          { command.run }

    describe 'init with real world params' do
      let(:params)  { {init: true, _: 1321868932700, target: '', test: 'test', token: 42, tree: true} }

      it            { should be_a(ElVfs::Command::ChangeWorkingDirectory::Result) }
    end

    describe '(init: true)' do
      let(:params)  { {init: true} }

      describe '#result' do

        its(:api)           { should == 2 }
        its(:cwd)           { should == root }
        its(:uplMaxSize)    { should == '16m' }
        its(:files)         { should == [] }

        describe '#files when files exists'  do
          before            { create_file }

          its(:files)       {  should == [file] }
        end

        describe '.options'  do
          require 'ostruct'
          let(:subject)         { OpenStruct.new result.options }

          its(:path)            { should == root.entry_name }
          its(:url)             { should =~ /^http:/ }
          its(:disabled)        { should == [] }
          its(:separator)       { should == '/' }
          its(:copyOverwrite)   { should == 1 }
          its(:archivers)       { should == {create: [], extract: []} }
        end

      end


      describe 'target: directory' do
        let(:params)      { {init: true, target: target} }

        its(:api)         { should == 2}
        its(:cwd)         { should == directory }
        its(:uplMaxSize)  { should == '16m' }
        describe '#files' do
          before          {p create_file }
          describe 'when files in root dir'  do
            its(:files)     { should == [] }
          end
          describe 'when files in current dir'  do
            let(:file)      { Fabricate(:file, :parent => directory) }
            alias :create_file :file

            its(:files)     { should == [file] }
          end
        end
        describe '.options'  do
          require 'ostruct'
          let(:subject)         { OpenStruct.new result.options }

          its(:path)            { should == 'root/directory' }
          its(:url)             { should =~ /^http:/ }
          its(:disabled)        { should == [] }
          its(:separator)       { should == '/' }
          its(:copyOverwrite)   { should == 1 }
          its(:archivers)       { should == {create: [], extract: []} }

        end

        describe 'tree: true' do
          let(:params)    { {init: true, target: target, tree: true} }
          let(:file)      { Fabricate(:file, :parent => directory) }
          alias :create_file :file

          before          { create_file }

          its(:api)       { should == 2 }
          its(:cwd)       { should == directory }
          its(:files)     { should == [file, root, directory] }
        end

      end
    end
  end

end
