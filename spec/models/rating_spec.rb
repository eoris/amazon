require 'rails_helper'

RSpec.describe Rating, type: :model do

  it { is_expected.to have_db_column(:review) }
  it { is_expected.to have_db_column(:rating) }
  it { is_expected.to have_db_column(:customer_id) }
  it { is_expected.to have_db_column(:book_id) }

  it { is_expected.to belong_to(:book) }
  it { is_expected.to belong_to(:customer) }

  it { is_expected.to validate_presence_of(:rating) }
  it { is_expected.to validate_presence_of(:review) }
  it { is_expected.to validate_numericality_of(:rating).is_less_than_or_equal_to(10) }
  it { is_expected.to validate_numericality_of(:rating).is_greater_than_or_equal_to(0) }

  describe 'aasm state' do
    before(:each) {@rating = Rating.new}

    it 'transitions from in_progress to in_queue' do
      expect(@rating).to transition_from(:moderation).to(:approved).on_event(:approve)
    end

    it 'transitions from in_queue to in_delivery' do
      expect(@rating).to transition_from(:moderation).to(:renounced).on_event(:reject)
    end
  end

  context '.state_enum' do
    it 'return state, except in_progress' do
      rating = create(:rating)
      expect(rating.state_enum).to match_array([["Approved", "approved"], ["Moderation", "moderation"], ["Renounced", "renounced"]])
    end
  end
end
