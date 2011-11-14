class CreateElVfsEntries < ActiveRecord::Migration
  def change
    create_table :el_vfs_entries do |t|
      t.string :type
      t.string :name
      t.string :hash
      t.string :ancestry
      t.timestamps
    end
  end
end
