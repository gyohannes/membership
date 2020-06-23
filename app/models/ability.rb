class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)

       if user.super_admin?
         can :manage, :all
         cannot :confirm, Person
         can :confirm, Person, status: nil
         cannot :edit, Person
         can :edit, Person, user_id: user.id
       elsif user.has_role('Admin')
         can :manage, :all
         cannot [:create, :edit], AssociationDetail
         cannot :manage, BoardMembersTerm
         cannot :manage, Event
         can :read, Event
         can :manage, Event, user_id: user.id
         cannot :confirm, Person
         can :confirm, Person, status: nil
         cannot :edit, Person
         can :edit, Person, user_id: user.id
       elsif user.has_role('Member')
         can :create, Person
         can :edit, Person, user_id: user.id
         can :create, SupportRequest
         can :read, :all
         can [:create, :member_fees], Payment
         can [:destroy, :edit], Payment, person_id: user.person.id, status: nil
       end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
