class Player
  def play_turn(warrior)
	  @warrior = warrior
	  return if healup
	  if immediate_captive
		  warrior.rescue! immediate_captive[:direction]
		  return
	  end
	  if immediate_danger
		  warrior.attack! immediate_danger[:direction]
		  return
	  end
	  warrior.walk! warrior.direction_of_stairs
  end
  def surroundings
	  return [:left, :right, :forward, :backward].map do |direction|
		  {:space => @warrior.feel(direction), :direction => direction}
	  end
  end
  def immediate_captive
	  surroundings.select { |place| place[:space].captive? } .first
  end
  def immediate_danger
	  surroundings.select { |place| place[:space].enemy? } .first
  end
  def escape!
	  [:left, :right, :forward, :backward].each do |direction|
		  if @warrior.feel(direction).empty?
			  @warrior.walk! direction
			  return true
		  end
	  end
	  return false
  end

  def danger
	  @warrior.listen.each do |unit|
		  return unit if unit.enemy?
	  end
	  return false
  end
  def captives?
	  @warrior.listen.each do |unit|
		  return unit if unit.captive?
	  end
	  return false
  end
  def healup
	  if @warrior.health < 10
		  if immediate_danger
			  return escape!
		  else
			  @warrior.rest!
		  end
	  else
		  return false
	  end
	  return true
  end
end
