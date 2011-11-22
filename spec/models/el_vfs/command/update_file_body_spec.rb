# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::UpdateFileBody do
    let(:params)        { {target: target, :content => 'new content ololo'} }
    let(:command)       { described_class.new params }
    let(:file)          { Fabricate(:file) }
    let(:target)        { file.target }

    describe 'target: file' do
      let(:subject)     { command.result }
      before            { command.run }

      its(:added)       { subject.map(&:entry_size).should == [17] }
    end
  end

end
