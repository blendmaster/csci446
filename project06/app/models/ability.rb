class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, :all if user.admin?
      if user.member?
        can :manage, Game # do |g|
        #  u == user # not sure why user: user hash isn't working
        # end
        can :update, User do |u|
          u == user
        end
      end
    end
  end
end
