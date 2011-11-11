class CreateVfsEntries < ActiveRecord::Migration
  def change
    create_table :vfs_entries do |t|
      t.string :name

      t.timestamps
    end
  end
end
