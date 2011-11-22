# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::DuplicateEntries do
    let(:params)        { {targets: targets} }
    let(:directory)     { Fabricate :directory, :parent => root }
    let(:file)          { Fabricate :file, :parent => root }
    let(:entries)       { [directory, file] }
    let(:targets)       { entries.map(&:target) }
    let(:command)       { Command::DuplicateEntries.new params }
    let(:root)          { Entry.root }
    alias :create_entries :entries

    before     { create_entries }

    describe '#result' do
      let(:subject)       { command.result }

      its(:added)         { subject.map(&:entry_name).should == ['directory copy1', 'file copy1.txt'] }
    end

    describe '#run' do
      it                  { expect{command.run}.to change{root.children.count}.by(2) }
    end

  end

end
