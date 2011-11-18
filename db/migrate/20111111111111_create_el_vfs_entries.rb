class CreateElVfsEntries < ActiveRecord::Migration
  def change
    create_table :el_vfs_entries do |t|
      t.string  :type
      t.string  :ancestry
      t.integer :ancestry_depth
      t.text    :entry_path
      t.text    :entry_path_hash
      t.string  :entry_name
      t.string  :entry_mime_type
      t.integer :entry_size
      t.integer :root_number
      t.timestamps
    end
    add_index :el_vfs_entries, :entry_name
    add_index :el_vfs_entries, :ancestry
    add_index :el_vfs_entries, :entry_path_hash
  end
end
