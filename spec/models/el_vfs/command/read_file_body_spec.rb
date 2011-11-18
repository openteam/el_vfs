# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::ReadFileBody do
    let(:params)        { {target: target} }
    let(:command)       { Command::ReadFileBody.new params }
    let(:subject)       { command.result }
    let(:file)          { Fabricate(:file) }
    let(:target)        { file.target }
    alias :create_file :file

    describe 'target: file' do
      its(:content)     { pending 'не сохраняются файлы'; should == 'content ololo' }
    end

    describe "without target" do
      let(:params)      { {} }

      its(:error)       { should == [:errCmdParams, :get] }
    end

    describe 'wrong: params, target: target' do
      let(:params)      { {wrong: 'params', target: target} }

      its(:error)       { should == [:errCmdParams, :get] }
    end
  end

end
