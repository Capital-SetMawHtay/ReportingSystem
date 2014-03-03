class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if(user.admin?)
      can :manage,User
      can :manage,Report
    elsif(user.member?)
      can :manage,Report do
        Report.this_week.where(:user_id => user.id)
      end
    elsif(user.leader?)
      can [:index,:show,:edit,:update],Report do
        Report.user.team_id == user.team_id
      end
    end

  end
end
