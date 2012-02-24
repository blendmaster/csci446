class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.text :body
      t.integer :edits, null: false, default: 0

      t.timestamps
    end
  end
end
