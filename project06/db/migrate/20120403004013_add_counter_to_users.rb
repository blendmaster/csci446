class AddCounterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :games_count, :int, default: 0
  end
    # don't need to do this anymore
    #User.reset_column_information
    #User.all.each do |u|
    #  u.update_attribute :games_count, u.games.count
    #end

  #end

  #def down
  #  remove_column :users, :games_count
  #end
end
