class Order < ApplicationRecord
  include AASM
  belongs_to :user
  has_many :order_items

  aasm column: 'state', no_direct_assignment: true do
    state :pending, initial: true
    state :paid, :delivered, :cancelled

    event :pay do
      transitions from: :pending, to: :paid
    end

    event :deliver do
      transitions from: :paid, to: :delivered
    end

    event :cancel do
      transitions from: [:paid, :deliver, :pending], to: :cancelled
    end
end

end
