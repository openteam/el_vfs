# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Command::CopyEntries do
    let(:valid_params)  { {src: source.target, dst: destination.target,  targets: targets} }
    let(:params)        { valid_params }
    let(:source)        { Fabricate :directory, :entry_name => 'source' }
    let(:destination)   { Fabricate :directory, :entry_name => 'destination' }
    let(:entries)       { [Fabricate(:file, :parent => source), Fabricate(:directory, :parent => source)] }
    let(:targets)       { entries.map(&:target) }
    alias :create_targets :targets
    let(:command)       { Command::CopyEntries.new params }
    let(:subject)       { command.result }

    describe 'default parameters' do
      its(:added)       { subject.map(&:entry_name).should == entries.map(&:entry_name) }
      its(:removed)     { should == [] }

      describe 'execute command' do
        before          { create_targets }

        it              { expect{command.result}.to change{destination.children.count}.by(2) }
        it              { expect{command.result}.to_not change{source.children.count} }
        it              { command.result; expect{entries.map(&:reload)}.should_not raise_error }

        describe 'cut: true' do
          let(:params)      { valid_params[:cut] = true; valid_params }

          its(:added)       { subject.map(&:entry_name).should == entries.map(&:entry_name) }
          its(:removed)     { should == entries.map(&:target) }

          describe 'execute command' do
            before          { create_targets }

            it              { expect{command.result}.to change{destination.children.count}.by(2) }
            it              { expect{command.result}.to change{source.children.count}.by(-2) }
            it              { command.result; expect{entries.map(&:reload)}.should raise_error ActiveRecord::RecordNotFound }
          end
        end
      end
    end

    describe "without targets" do
      let(:params)      { valid_params.delete :targets; valid_params }
      its(:error)       { should == [:errCmdParams, :paste] }
    end

    describe "without src" do
      let(:params)      { valid_params.delete :src; valid_params }
      its(:error)       { should == [:errCmdParams, :paste] }
    end

    describe "without dst" do
      let(:params)      { valid_params.delete :dst; valid_params }
      its(:error)       { should == [:errCmdParams, :paste] }
    end

    describe "with empty paste" do
      let(:params)      { {targets: targets, paste: []} }
      its(:error)       { should == [:errCmdParams, :paste] }
    end

    describe 'wrong: params' do
      let(:params)      { valid_params[:wrong]='params'; valid_params }
      its(:error)       { should == [:errCmdParams, :paste] }
    end
  end

end
