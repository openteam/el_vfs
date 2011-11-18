# encoding: utf-8

require 'spec_helper'

module ElVfs
  describe Directory do
    it { should validate_presence_of :entry_name }

    let(:directory) { Fabricate :directory }

    it { directory.entry_path.should == 'r1/directory/' }

    describe 'вложенная на 1 уровень' do
      let(:subject) { Fabricate(:directory, :parent => directory, :entry_name => 'nested') }

      its(:entry_path) { should == 'r1/directory/nested/' }
    end

    describe '.duplicate' do
      let(:subject)       { directory.duplicate }

      its(:entry_name)    { should == 'directory copy1' }

      describe 'if copies already exists' do
        before { Fabricate(:directory, :entry_name => 'directory copy1') }

        its(:entry_name)   { should == 'directory copy2' }
      end

      describe 'copy must be deep' do
        let(:subdirectory)          { Fabricate :directory, :parent => directory, :entry_name => 'subdirectory' }
        let(:file_in_subdirectory)  { Fabricate :file, :parent => subdirectory }
        let(:subject)               { file_in_subdirectory.parent.parent.duplicate }

        its(:descendants)           { subject.map(&:entry_name).should == ['subdirectory', 'file.txt'] }
        its(:descendants)           { subject.map(&:depth).should == [2, 3] }
      end
    end

    describe 'el_hash' do
      let(:subject)   { OpenStruct.new directory.el_hash }
      its(:name)      { should == 'directory' }
      its(:hash)      { directory.el_hash[:hash].should == 'r1_ZGlyZWN0b3J5' }
      its(:phash)     { should == 'r1_Lw' }
      its(:mime)      { should == 'directory' }
      its(:date)      { should == I18n.l(Time.now) }
      its(:size)      { should == 0 }
      its(:dirs)      { should == 0 }
      it              { directory.parent.el_hash[:dirs].should == 1 }
      its(:read)      { should == 1 }
      its(:write)     { should == 1 }
      its(:locked)    { should == 0 }
    end


  end
end
