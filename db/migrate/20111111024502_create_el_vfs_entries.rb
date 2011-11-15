class CreateElVfsEntries < ActiveRecord::Migration
  def change
    create_table :el_vfs_entries do |t|
      t.string  :type
      t.string  :ancestry
      t.text    :file_uid
      t.string  :file_name
      t.string  :file_mime_type
      t.integer :file_size
      t.string  :hash
      t.timestamps
    end
  end
end
