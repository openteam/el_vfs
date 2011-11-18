# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::UpdateFileBody do
    let(:params)        { {target: target, :content => 'new content ololo'} }
    let(:command)       { Command::UpdateFileBody.new params }
    let(:subject)       { command.result }
    let(:file)          { Fabricate(:file) }
    let(:target)        { file.target }

    describe 'target: file' do
      its(:added)       { subject.entry_size.should == 17 }
    end
  end

end
