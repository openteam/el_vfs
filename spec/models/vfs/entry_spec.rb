require 'spec_helper'

module Vfs
  describe Entry do
   it { should validate_presence_of :name }
  end
end
