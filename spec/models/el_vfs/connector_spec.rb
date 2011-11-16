# encoding: utf-8

require 'spec_helper'

module ElVfs

  describe Connector do

    let(:connector) { Connector.new }
    let(:directory)  { Fabricate :directory }
    def command_for(name)
      connector.command_for(:cmd => name)
    end
    describe 'поиск команд' do
      it { command_for(:not_supported).should be_a(ElVfs::Command::Unknown) }
      it { command_for(:archive).should be_a(ElVfs::Command::PackEntries) }
      it { command_for(:duplicate).should be_a(ElVfs::Command::DuplicateEntry) }
      it { command_for(:edit).should be_a(ElVfs::Command::UpdateFileBody) }
      it { command_for(:extract).should be_a(ElVfs::Command::UnpackEntry) }
      it { command_for(:file).should be_a(ElVfs::Command::SendFile) }
      it { command_for(:ls).should be_a(ElVfs::Command::ListNames) }
      it { command_for(:mkdir).should be_a(ElVfs::Command::CreateDirectory) }
      it { command_for(:mkfile).should be_a(ElVfs::Command::CreateFile) }
      it { command_for(:open).should be_a(ElVfs::Command::ChangeWorkingDirectory) }
      it { command_for(:parents).should be_a(ElVfs::Command::GetParents) }
      it { command_for(:paste).should be_a(ElVfs::Command::CopyEntries) }
      it { command_for(:ping).should be_a(ElVfs::Command::Ping) }
      it { command_for(:read).should be_a(ElVfs::Command::ReadFileBody) }
      it { command_for(:rename).should be_a(ElVfs::Command::RenameEntry) }
      it { command_for(:resize).should be_a(ElVfs::Command::ResizeImage) }
      it { command_for(:rm).should be_a(ElVfs::Command::DestroyEntries) }
      it { command_for(:tmb).should be_a(ElVfs::Command::CreateThumbnail) }
      it { command_for(:tree).should be_a(ElVfs::Command::GetSubtree) }
      it { command_for(:upload).should be_a(ElVfs::Command::UploadFiles) }
    end
  end
end
