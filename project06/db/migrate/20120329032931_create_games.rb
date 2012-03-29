class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.enum :rating

      t.timestamps
    end
  end
end
