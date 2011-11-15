require 'spec_helper'

module ElVfs

  describe Command::ChangeWorkingDirectory do

    def command(params={})
      @command ||= Command::ChangeWorkingDirectory.new params
    end

    its(:result) { should == {:error => [:errCmdParams, :open]} }

    describe 'init => true' do
      let(:subject) { command :init => true }
      its(:result) { should == {:api => 2, :cwd => Entry.root.el_hash, :files => [], :options => []} }
    end

    describe 'target => directory' do
      let(:directory) { Fabricate :directory }
      let(:subject) { command :target => directory.entry_uid_hash }
      its(:result) { should == {:cwd => directory.el_hash, :files => []} }

      describe 'init => true' do
        let(:subject) { command :target => directory.entry_uid_hash, :init => true }
        its(:result) { should == {:api => 2, :cwd => directory.el_hash, :files => [], :options => []} }
      end
    end
  end

end
