require 'spec_helper'
require 'ostruct'
module ElVfs
  describe Root do
    it { should validate_presence_of :entry_name }

    let(:root) { Fabricate :root }
    let(:another_root) { Fabricate :root }
    alias :create_root :root
    alias :create_another_root :another_root
    alias :subject :root

    its(:entry_name)      { should == 'Root' }
    its(:entry_path)      { should == 'r1/' }
    its(:entry_path_hash) { should == 'r1_Lw' }
    its(:root_number)     { should == 1 }

    describe 'AnotherRoot' do
      before { create_root }
      alias :subject :another_root

      its(:entry_path)      { should == 'r2/' }
      its(:entry_path_hash) { should == 'r2_Lw' }
      its(:root_number)     { should == 2 }
    end

    describe 'root.el_hash' do
      let(:subject) { OpenStruct.new root.el_hash }

      its(:name)  { should == 'Root' }
      its(:hash)  { root.el_hash[:hash].should == 'r1_Lw' }
      its(:phash) { should == '' }
      its(:mime)  { should == 'directory' }
      its(:date)  { should == I18n.l(Time.now) }
      its(:size)  { should == 0 }

      describe 'dirs' do
        its(:dirs) { should == 0 }

        describe 'when directory exist'  do
          before { Fabricate :directory, :parent => root }

          its(:dirs) { should == 1 }
        end
      end

      its(:read)      { should == 1 }
      its(:write)     { should == 1 }
      its(:locked)    { should == 0 }
      its(:volumeid)  { should == 'r1_'}
    end
  end
end
