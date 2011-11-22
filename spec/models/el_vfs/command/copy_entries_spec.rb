# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::CopyEntries do
    let(:params)        { {src: source.target, dst: destination.target,  targets: targets, cut: '0'} }
    let(:source)        { Fabricate :directory, :entry_name => 'source' }
    let(:destination)   { Fabricate :directory, :entry_name => 'destination' }
    let(:entries)       { [Fabricate(:file, :parent => source), Fabricate(:directory, :parent => source)] }
    let(:targets)       { entries.map(&:target) }
    let(:command)       { described_class.new params }
    alias :create_targets :targets

    before              { create_targets }

    describe 'default parameters' do
      describe '#result' do
        before          { command.run }
        let(:subject)   { command.result }

        its(:added)     { subject.map(&:entry_name).should == entries.map(&:entry_name) }
        its(:removed)   { should == [] }
      end

      describe 'execute command' do
        it              { expect{command.run}.to change{destination.children.count}.by(2) }
        it              { expect{command.run}.to_not change{source.children.count} }
        it              { command.run; expect{entries.map(&:reload)}.should_not raise_error }
      end
    end

    describe 'cut: true' do
      alias :valid_params :params
      let(:params)      { valid_params[:cut] = true; valid_params }

      describe '#result' do
        before          { command.run }
        let(:subject)   { command.result }

        its(:added)     { should == entries.map(&:reload) }
        its(:removed)   { should == entries.map(&:target) }
      end

      describe 'execute command' do
        it              { expect{command.run}.to change{destination.children.count}.by(2) }
        it              { expect{command.run}.to change{source.children.count}.by(-2) }
      end
    end
  end

end
