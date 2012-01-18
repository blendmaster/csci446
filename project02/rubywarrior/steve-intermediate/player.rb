class Player
  def play_turn(warrior)
	  @warrior = warrior
	  return if healup
	  if danger
		  warrior.attack! danger
		  return
	  end
	  warrior.walk! warrior.direction_of_stairs
  end
  def danger
	  [:left, :right, :forward, :backward].each do |direction| 
		  if @warrior.feel(direction).enemy?
			  return direction
		  end
	  end
	  return false
  end
  def healup
	  if @warrior.health < 10
		  if danger
			  @warrior.walk! :backward
		  else
			  @warrior.rest!
		  end
	  else
		  return false
	  end
	  return true
  end
end
