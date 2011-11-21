require 'spec_helper'

module ElVfs

  describe Command::ChangeWorkingDirectory do
    let(:params)    { {} }
    let(:command)   { Command::ChangeWorkingDirectory.new params }
    let(:root)      { Entry.root }
    let(:directory) { Fabricate :directory, :parent => root }
    let(:target)    { directory.target }
    let(:result)    { command.result }

    before          { command.run; p command.errors unless command.valid? }

    describe 'init with real world params' do
      let(:params)  { {init: true, _: 1321868932700, target: '', test: 'test', token: 42, tree: true} }
      let(:subject) { result }

      it            { should be_a(ElVfs::Command::ChangeWorkingDirectory::Result) }
    end

    describe '(init: true)' do
      let(:params)  { {init: true} }

      describe '#result' do
        let(:subject)       { result }

        its(:api)           { should == 2 }
        its(:cwd)           { should == root }
        its(:uplMaxSize)    { should == '16m' }
        its(:files)         { should == [] }

        describe '#files when files exists'  do
          let(:file)        { Fabricate(:file, :parent => root)}
          alias :create_file :file

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



      #describe 'target: directory' do
        #let(:params)      { {init: true, target: target} }
        #let(:directory)   { Fabricate(:directory) }

        #its(:api)         { should == 2}
        #its(:cwd)         { should == directory.el_hash }
        #its(:uplMaxSize)  { should == '16m' }
        #its(:files)       { should == [file] }
        #its(:options)     { should == [] }

        #describe 'tree: true' do
          #let(:params)    { {init: true, target: target, tree: true} }
          #before          { Fabricate(:file, :parent => root )}

          #its(:api)       { should == 2}
          #its(:cwd)       { should == directory.el_hash }
          #its(:files)     { should == [root, directory, file].map(&:el_hash) }
        #end
      #end
    end

    #describe 'target: directory' do
      #let(:directory) { Fabricate :directory }
      #let(:params)    { {target: target} }

      #its(:cwd) { should == directory.el_hash }
    #end

    #describe 'wrong: params, target: target' do
      #let(:params) { {wrong: 'params', target: target} }

      #its(:error) { should == [:errCmdParams, :open] }
    #end
  end

end
