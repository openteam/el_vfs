class CreateElVfsEntries < ActiveRecord::Migration
  def change
    create_table :el_vfs_entries do |t|
      t.string  :type
      t.string  :ancestry
      t.integer :ancestry_depth
      t.text    :entry_uid
      t.text    :entry_uid_hash
      t.string  :entry_name
      t.string  :entry_mime_type
      t.integer :entry_size
      t.timestamps
    end
    add_index :el_vfs_entries, :ancestry
    add_index :el_vfs_entries, :entry_uid_hash
  end
end
