require 'spec_helper'

module ElVfs
  describe Entry do
    it { should validate_presence_of :name }
    describe Entry.root do
      let(:subject) { Entry.root }
      it { should_not be_nil }
      it { should be_instance_of Directory }
      its(:name) { should == '/' }
    end
  end
end
