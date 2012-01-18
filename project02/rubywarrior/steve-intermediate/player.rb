class Player
  def play_turn(warrior)
	  if warrior.health < 3
		  warrior.rest!
		  return
	  end
	  if danger(warrior)
		  warrior.attack! danger(warrior)
		  return
	  end
	  warrior.walk! warrior.direction_of_stairs
  end
  def danger(warrior)
	  [:left, :right, :forward, :backward].each do |direction| 
		  if warrior.feel(direction).enemy?
			  return direction
		  end
	  end
	  return false
  end
end
