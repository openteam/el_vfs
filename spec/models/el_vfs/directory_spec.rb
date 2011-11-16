# encoding: utf-8

require 'spec_helper'

module ElVfs
  describe Directory do
    it { should validate_presence_of :entry_name }

    let(:directory) { Fabricate :directory }

    it { directory.entry_path.should == 'r1/directory/' }

    it { directory.el_hash[:name].should == 'directory' }
    it { directory.el_hash[:hash].should == 'r1_ZGlyZWN0b3J5' }
    it { directory.el_hash[:phash].should == 'r1_Lw' }
    it { directory.el_hash[:mime].should == 'directory' }
    it { directory.el_hash[:date].should == I18n.l(Time.now) }
    it { directory.el_hash[:size].should == 0 }
    it { directory.el_hash[:dirs].should == 0 }
    it { directory.parent.el_hash[:dirs].should == 1 }
    it { directory.el_hash[:read].should == 1 }
    it { directory.el_hash[:write].should == 1 }
    it { directory.el_hash[:locked].should == 0 }

    describe 'вложенная на 1 уровень' do
      let(:directory) { Fabricate(:directory, :parent => Fabricate(:directory, :entry_name => :root)) }
      it { directory.entry_path.should == 'r1/root/directory/' }
    end

  end
end
