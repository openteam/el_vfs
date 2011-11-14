# encoding: utf-8

require 'spec_helper'

describe ElVfs::Connector do

  let(:connector) { ElVfs::Connector.new :url => '/elfinder' }

  delegate :run, :headers, :response, :to => :connector

  describe "запуск без указания команды" do
    before { run }
    it { headers.should be_instance_of Hash }
    it { response.should be_instance_of Hash }
  end

  describe "должен вернуть invalid command если неверная команда" do
    before { run :cmd => :invalid }
    it { response[:error].should_not be_nil }
    it { response[:error].should =~ /invalid command/i }
  end

  describe "init via open" do
    before { run(:cmd => 'open', :init => 'true', :target => '') }

    it { response[:cwd].should_not be_nil }
    it { response[:cdc].should_not be_nil }
    it { response[:disabled].should_not be_nil }
    it { response[:params].should_not be_nil }


    describe 'current directory content' do
      before  { Fabricate :directory }
    end

    it do
      response[:cdc].each do |entry|
        case entry[:name]
        when 'foo'
          assert_nil entry[:dim]
          assert_nil entry[:resize]
          assert_equal 'directory', entry[:mime]
          assert_equal 0, entry[:size]
        when 'pjkh.png'
          assert_equal '100x100', entry[:dim]
          assert entry[:resize]
          assert_equal 'image/png', entry[:mime]
          assert_equal 1142, entry[:size]
        end
      end
    end
  end

end
