require 'spec_helper'

describe ElVfs::File do
  it { should validate_presence_of :entry_name }

  let(:file) { Fabricate :file }

  it { file.el_hash[:name].should == 'file.txt' }
  it { file.el_hash[:hash].should == 'ZGlyZWN0b3J5L2ZpbGUudHh0' }
  it { file.el_hash[:date].should == I18n.l(Time.now) }
  it { file.el_hash[:mime].should == 'text/plain' }
  it { file.el_hash[:size].should == 10 }
  it { file.el_hash[:read].should == true }
  it { file.el_hash[:write].should == true }
  it { file.el_hash[:rm].should == true }

end
