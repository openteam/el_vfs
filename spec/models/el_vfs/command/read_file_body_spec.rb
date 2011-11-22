# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::ReadFileBody do
    let(:params)        { {target: file.target} }
    let(:command)       { described_class.new params }
    let(:file)          { Fabricate(:file) }
    alias :create_file :file

    describe 'target: file # result' do
      let(:subject)     { command.result }
      before            { command.run }
      its(:content)     { pending 'не сохраняются файлы'; should == 'content ololo' }
    end

  end

end
