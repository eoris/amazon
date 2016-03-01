class Order < ActiveRecord::Base
  include AASM
  belongs_to :customer
  belongs_to :delivery
  has_many :order_items
  has_one :credit_card
  has_one :billing_address
  has_one :shipping_address

  validates :total_price, :completed_date, :state, presence: true

  aasm column: :state do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :in_queue do
      transitions from: :in_progress, to: :in_queue
    end

    event :in_delivery do
      transitions from: :in_queue, to: :in_delivery
    end

    event :delivered do
      transitions from: :in_delivery, to: :delivered
    end

    event :canceled do
      transitions from: [:in_queue, :in_delivery], to: :canceled
    end
  end

  def state_enum
    ['in_queue', 'in_delivery', 'delivered', 'canceled']
  end
end
