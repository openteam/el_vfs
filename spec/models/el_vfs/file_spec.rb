require 'spec_helper'

describe ElVfs::File do
  it { should validate_presence_of :entry_name }

  let(:file) { Fabricate :file }

  def json
    ActiveSupport::JSON.decode(file.el_json).with_indifferent_access
  end

  it { json[:name].should == 'file.txt' }
  it { json[:hash].should == '/directory/file.txt' }
  it { json[:date].should == I18n.l(Time.now) }
  it { json[:mime].should == 'text/plain' }
  it { json[:size].should == 10 }
  it { json[:read].should == true }
  it { json[:write].should == true }
  it { json[:rm].should == true }

end
