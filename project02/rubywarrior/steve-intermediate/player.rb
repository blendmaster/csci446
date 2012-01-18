class Player
  def directions
	  [:left, :right, :forward, :backward]
  end
  def play_turn(warrior)
	  @warrior = warrior
	  return if healup
	  if immediate_captive
		  return warrior.rescue! direction_of immediate_captive
	  end
	  if ticking_captive
		  return rescue_ticking!
	  end
	  if immediate_danger
		  return warrior.attack! direction_of immediate_danger
	  end
	  if captives
		  return adventure! direction_of captives
	  end
	  if danger
		  return adventure! direction_of danger
	  end
	  warrior.walk! warrior.direction_of_stairs
  end
  def ticking_captive
	  @warrior.listen.each do |space|
		  return space if space.captive? and space.ticking?
	  end
	  return false
  end
	  
  def rescue_ticking!
	  if surroundings.include? ticking_captive
		  return @warrior.rescue! direction_of ticking_captive
	  end
	  if adventurable?(@warrior.feel direction_of ticking_captive)
		  return @warrior.walk! direction_of ticking_captive
	  end
	  ([:forward,:left,:right].shuffle).concat([:backward]).each do |direction|
		  if adventurable?(@warrior.feel(direction))
			  return @warrior.walk! direction
		  end
	  end
  end
  def adventurable?(space)
	  return (!space.stairs? and space.empty?)
  end
  def adventure!(direction)
	  if @warrior.feel(direction).stairs?
		  surroundings.shuffle.each do |space|
			  if adventurable? space
				  return @warrior.walk! direction_of space
			  end
		  end
	  end
	  @warrior.walk! direction
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
