class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.has_attached_file :photo
      t.timestamps
    end
  end
end
