# encoding: utf-8

require 'spec_helper'

module ElVfs
  describe Directory do
    it { should validate_presence_of :entry_name }

    describe Directory.root do
      let(:subject) { ElVfs::Directory.root }
      its(:entry_name) { should == '' }
      its(:entry_uid) { should == '' }
    end

    let(:directory) { Fabricate :directory }

    it { directory.entry_uid.should == '/directory' }

    it { directory.el_hash[:name].should == 'directory' }
    it { directory.el_hash[:hash].should == 'ZGlyZWN0b3J5' }
    it { directory.el_hash[:date].should == I18n.l(Time.now) }
    it { directory.el_hash[:mime].should == 'directory' }
    it { directory.el_hash[:size].should == 0 }
    it { directory.el_hash[:read].should == true }
    it { directory.el_hash[:write].should == true }
    it { directory.el_hash[:rm].should == true }

    describe 'вложенная на 1 уровень' do
      let(:directory) { Fabricate(:directory, :parent => Fabricate(:directory, :entry_name => :root)) }
      it { directory.entry_uid.should == '/root/directory' }
    end

  end
end
