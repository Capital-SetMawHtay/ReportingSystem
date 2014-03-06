class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if(user.admin?)
      can :manage,User
      can :manage,Report
      can :manage,Team
      can :manage,TeamReport
    elsif(user.member?)
      can [:show],User,:id => user.id
      can :index,Team,:users =>{:id => user.id}
      can [:index,:create], Report
      can :manage, Report.where(:user_id => user.id)
    elsif(user.leader?)
      can [:show],User
      can :show, Team
      can :manage,Report,:user => {:team =>{:users => {id: user.id}}}
      can :manage, TeamReport,:team =>{:users => {:id => user.id}}
    else
    end

  end
end
