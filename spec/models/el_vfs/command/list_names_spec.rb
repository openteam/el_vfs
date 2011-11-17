# encoding: utf-8
# ls
# Вернуть список имен файлов в заданой директории.
#   Аргументы:
#     cmd : ls
#     target : hash директории,
#   Ответ:
#     list : (Array) Список имен файлов

require 'spec_helper'

module ElVfs

  describe Command::SendFile do
    let(:params)    { {} }
    let(:command)   { Command::ListNames.new params }
    let(:subject)   { command.result }
    let(:root)      { Entry.root }
    let(:directory) { Fabricate :directory, :parent => root }
    let(:file)      { Fabricate(:file, :parent => root)}
    let(:target)    { root.target }
    alias :create_directory :directory
    alias :create_file :file

    describe 'target: root' do
      let(:params)    { {target: target} }
      before { create_file; create_directory }
      its(:list) { should == [file.entry_name] }
    end

    describe "without target" do
      its(:error) { should == [:errCmdParams, :ls] }
    end

    describe 'wrong: params, target: target' do
      let(:params) { {wrong: 'params', target: target} }
      its(:error) { should == [:errCmdParams, :ls] }
    end
  end

end
