class CreateElVfsEntries < ActiveRecord::Migration
  def change
    create_table :el_vfs_entries do |t|
      t.string :name
      t.string :type
      t.timestamps
    end
  end
end
