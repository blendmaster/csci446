class Player
  def directions
	  [:left, :right, :forward, :backward]
  end
  def play_turn(warrior)
	  @warrior = warrior
	  return if healup
	  if immediate_captive
		  warrior.rescue! direction_of immediate_captive
		  return
	  end
	  if immediate_danger
		  warrior.attack! direction_of immediate_danger
		  return
	  end
	  if captives
		  warrior.walk! direction_of captives
		  return
	  end
	  if danger
		  warrior.walk! direction_of danger
		  return
	  end
	  warrior.walk! warrior.direction_of_stairs
  end
  def direction_of(space)
	  @warrior.direction_of(space)
  end
  def surroundings
	  directions.map { |direction| @warrior.feel(direction) }
  end
  def immediate_captive
	  surroundings.select { |space| space.captive? } .first
  end
  def immediate_danger
	  surroundings.select { |space| space.enemy? } .first
  end
  def escape!
	  surroundings.each do |space|
		  if space.empty?
			  @warrior.walk! direction_of space
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
  def captives
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
