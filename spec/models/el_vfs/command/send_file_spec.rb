# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::SendFile do
    let(:params)    { {} }
    let(:command)   { Command::SendFile.new params }
    let(:subject)   { command.result }
    let(:root)      { Entry.root }
    let(:directory) { Fabricate :directory, :parent => root }
    alias :create_directory :directory
    let(:file)      { Fabricate(:file, :parent => directory)}
    let(:target)    { file.target }
    alias :create_file :file


    describe 'target: file' do
      let(:params)    { {target: target} }
      it { pending 'не сохраняются фалы'; should == 'some text' }
    end

    describe "without target" do
      its(:error) { should == [:errCmdParams, :file] }
    end

    describe 'wrong: params, target: target' do
      let(:params) { {wrong: 'params', target: target} }
      its(:error) { should == [:errCmdParams, :file] }
    end
  end

end
