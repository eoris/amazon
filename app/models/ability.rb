class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Customer.new
    can [:read, :bestsellers], Book
    can :read, Category
    can :read, Author
    can :manage, Cart
    if user.id
      can [:new, :create], Rating, customer_id: user.id
      can [:read, :checkout], Order, customer_id: user.id
      can :update, Customer, customer_id: user.id
    end
  end
end
