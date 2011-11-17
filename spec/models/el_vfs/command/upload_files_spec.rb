# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::UploadFiles do
    let(:params)    { {target: target, upload: files} }
    let(:files)     { [::File.open("#{SPEC_ROOT}/fixtures/file.txt")] }
    let(:command)   { Command::UploadFiles.new params }
    let(:subject)   { command.result }
    let(:root)      { Entry.root }
    let(:target)    { root.target }

    describe 'target: root' do
      its(:added)   { should == root.files }
      it            { expect{command.result}.to change{root.files.count}.by(1) }
    end

    describe "without target" do
      let(:params)    { {upload: files} }
      its(:error) { should == [:errCmdParams, :upload] }
    end

    describe "without upload" do
      let(:params)    { {target: target} }
      its(:error) { should == [:errCmdParams, :upload] }
    end

    describe "with empty upload" do
      let(:params)    { {target: target, upload: []} }
      its(:error) { should == [:errCmdParams, :upload] }
    end

    describe 'wrong: params, target: target' do
      let(:params) { {wrong: 'params', target: target} }
      its(:error) { should == [:errCmdParams, :upload] }
    end
  end

end
