# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::Ping do
    let(:params)    { {} }
    let(:command)   { Command::Ping.new params }

    describe 'run ping' do
      it { command.headers.should == { 'Conncetion' => 'close' } }
      it { command.result.should == '' }
    end

    describe 'wrong: params' do
      let(:params) { {wrong: 'params'} }
      it { command.result.error.should == [:errCmdParams, :ping] }
    end
  end

end
