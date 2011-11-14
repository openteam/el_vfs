require 'spec_helper'

module ElVfs
  describe Directory do
    it { should validate_presence_of :name }

    describe Directory.root do
      let(:subject) { ElVfs::Directory.root }
      its(:name) { should == '' }
      its(:entry_path) { should == '/' }
    end

    def directory(options={})
      @directory ||= Fabricate :directory, options
    end

    def json(options={})
     ActiveSupport::JSON.decode(directory(options).to_json).with_indifferent_access
    end

    it { directory.entry_path.should == '/directory' }
    it { directory(:parent => Fabricate(:directory, :name => :root)).entry_path.should == '/root/directory' }

    it { json[:name].should == 'directory' }
    it { json[:hash].should == 'L2RpcmVjdG9yeQ==' }
    it { json[:rel].should == 'directory' }
    it { json[:date].should == I18n.l(Time.now) }
    it { json[:mime].should == 'directory' }
    it { json[:size].should == 0 }
    it { json[:read].should == true }
    it { json[:write].should == true }
    it { json[:rm].should == true }
    it { json(:parent => Fabricate(:directory, :name => 'root'))[:rel].should == 'root/directory' }

  end
end
