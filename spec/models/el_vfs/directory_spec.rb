# encoding: utf-8

require 'spec_helper'

module ElVfs
  describe Directory do
    it { should validate_presence_of :file_name }

    describe Directory.root do
      let(:subject) { ElVfs::Directory.root }
      its(:file_name) { should == '' }
      its(:file_uid) { should == '/' }
    end

    let(:directory) { Fabricate :directory }

    def json(options={})
      ActiveSupport::JSON.decode(directory.el_json).with_indifferent_access
    end

    it { directory.file_uid.should == '/directory' }

    it { json[:name].should == 'directory' }
    it { json[:hash].should == '/directory' }
    it { json[:date].should == I18n.l(Time.now) }
    it { json[:mime].should == 'directory' }
    it { json[:size].should == 0 }
    it { json[:read].should == true }
    it { json[:write].should == true }
    it { json[:rm].should == true }

    describe 'вложенная на 1 уровень' do
      let(:directory) { Fabricate(:directory, :parent => Fabricate(:directory, :file_name => :root)) }
      it { directory.file_uid.should == '/root/directory' }
    end

  end
end
