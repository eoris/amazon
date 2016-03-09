class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Customer.new
    can [:read, :bestsellers], Book
    can :read, Category
    can :read, Author
    can :read, Rating
    can :manage, Cart
    if user.id
      can [:new, :create], Rating, customer_id: user.id
      can [:read, :checkout], Order, customer_id: user.id
      can [:edit, :update, :update_billing, :update_shipping], Customer, id: user.id
    end
  end
end
