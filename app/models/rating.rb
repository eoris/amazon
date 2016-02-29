class Rating < ActiveRecord::Base
  include AASM
  belongs_to :customer
  belongs_to :book

  validates :rating, :review, presence: true
  validates_numericality_of :rating, less_than_or_equal_to: 10
  validates_numericality_of :rating, greater_than_or_equal_to: 0

  aasm column: :state do
    state :moderation, initial: true
    state :approved
    state :renounced

    event :approve do
      transitions from: :moderation, to: :approved
    end

    event :reject do
      transitions from: :moderation, to: :renounced
    end
  end

  def state_enum
    self.class.aasm.states_for_select
  end
end
