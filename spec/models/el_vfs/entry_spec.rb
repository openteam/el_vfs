require 'spec_helper'

module ElVfs
  describe Entry do
    it { should validate_presence_of :name }
  end
end
