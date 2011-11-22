# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::UploadFiles do
    let(:files)     { [::File.open("#{SPEC_ROOT}/fixtures/file.txt")] }
    let(:command)   { described_class.new params }
    let(:root)      { Entry.root }
    let(:params)    { {target: root.target, upload: files} }

    describe 'target: root' do
      describe 'run' do
        it          { expect{command.run}.to change{root.files.count}.by(1) }
      end
      describe 'result' do
        let(:subject) { command.result }
        before        { command.run }
        its(:added)   { should == root.files }
      end
    end
  end

end
