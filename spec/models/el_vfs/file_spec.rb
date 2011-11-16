require 'spec_helper'

describe ElVfs::File do
  it { should validate_presence_of :entry_name }

  let(:file) { Fabricate :file }

  it { file.el_hash[:name].should == 'file.txt' }
  it { file.el_hash[:hash].should == 'l0_ZGlyZWN0b3J5L2ZpbGUudHh0' }
  it { file.el_hash[:phash].should == 'l0_ZGlyZWN0b3J5' }
  it { file.el_hash[:mime].should == 'text/plain' }
  it { file.el_hash[:date].should == I18n.l(Time.now) }
  it { file.el_hash[:size].should == 10 }
  it { file.el_hash.should_not have_key(:dirs) }
  it { file.el_hash[:read].should == 1 }
  it { file.el_hash[:write].should == 1 }
  it { file.el_hash[:locked].should == 0 }
  it { file.el_hash.should_not have_key(:tmb) }
  # 'bac0d45b625f8d4633435ffbd52ca495.png' - имя файла превьюшки (для картинок). Если файл не имеет превью, но оно может быть создано, поле принимает значение "1"
end
