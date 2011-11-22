require 'spec_helper'

module ElVfs

  describe Command::RenameEntry do
    let(:params)      { {target: entry.target, :name => 'new_name'} }
    let(:root)        { Entry.root }
    let(:directory)   { Fabricate :directory }
    let(:file)        { Fabricate :file }
    let(:command)     { described_class.new params }

    before            { command.run }

    describe 'target: directory' do
      alias :entry :directory

      describe 'run command' do
        it            { entry.reload.entry_name.should == 'new_name' }
      end

      describe '#result' do
        let(:subject) { command.result }

        its(:added)   { should == [directory.reload] }
        its(:removed) { should == [directory.target] }
      end
    end

    describe 'target: file' do
      alias :entry :file

      describe '#result' do
        let(:subject) { command.result }

        its(:added)   { should == [file.reload] }
        its(:removed) { should == [file.target] }
      end
    end

  end

end
