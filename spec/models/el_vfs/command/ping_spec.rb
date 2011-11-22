# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::Ping do
    let(:params)    { {} }
    let(:command)   { described_class.new params }

    before          { command.run }

    describe "#headers" do
      let(:subject) { command.headers }

      it            { should == { 'Connection' => 'close' } }
    end

  end

end
