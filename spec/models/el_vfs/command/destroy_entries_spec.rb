# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::DestroyEntries do
    let(:params)        { {targets: targets} }
    let(:file)          { Fabricate :file, :parent => root }
    let(:directory)     { Fabricate :directory, :parent => root }
    let(:entries)       { [file, directory] }
    alias :create_entries :entries
    let(:targets)       { entries.map(&:target) }
    let(:command)       { described_class.new params }
    let(:root)          { Entry.root }

    before          { create_entries }

    describe 'default parameters' do
      describe 'result' do
        before            { command.run }
        let(:subject)     { command.result }

        its(:removed)     { should == [file.target, directory.target] }
      end

      describe 'execute command' do
        it              { expect{command.run}.to change{root.children.count}.by(-2) }
        it              { command.run; expect{entries.map(&:reload)}.should raise_error ActiveRecord::RecordNotFound }
      end
    end
  end
end
