# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::SendFile do
    let(:params)    { {} }
    let(:command)   { Command::SendFile.new params }
    let(:root)      { Entry.root }
    let(:directory) { Fabricate :directory, :parent => root }
    alias :create_directory :directory
    let(:file)      { Fabricate(:file, :parent => directory)}
    let(:target)    { file.target }
    alias :create_file :file


    describe 'target: file' do
      let(:params)  { {target: target} }
      let(:subject) { command }
      before        { command.run }
      its(:headers) { subject['Location'].should == file.url }
    end

  end

end
