class CreateElVfsEntries < ActiveRecord::Migration
  def change
    create_table :el_vfs_entries do |t|
      t.string  :type
      t.string  :ancestry
      t.text    :entry_uid
      t.string  :entry_name
      t.string  :entry_mime_type
      t.integer :entry_size
      t.timestamps
    end
  end
end
