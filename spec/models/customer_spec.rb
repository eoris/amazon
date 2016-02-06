require 'rails_helper'

RSpec.describe Customer, type: :model do

  it { is_expected.to have_db_column(:email) }
  it { is_expected.to have_db_column(:firstname) }
  it { is_expected.to have_db_column(:lastname) }
  it { is_expected.to have_db_column(:encrypted_password) }
  it { is_expected.to have_db_column(:reset_password_token) }
  it { is_expected.to have_db_column(:reset_password_sent_at) }
  it { is_expected.to have_db_column(:remember_created_at) }
  it { is_expected.to have_db_column(:sign_in_count) }
  it { is_expected.to have_db_column(:current_sign_in_at) }
  it { is_expected.to have_db_column(:last_sign_in_at) }
  it { is_expected.to have_db_column(:current_sign_in_ip) }
  it { is_expected.to have_db_column(:last_sign_in_ip) }

  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }

  it { is_expected.to have_many(:orders) }
  it { is_expected.to have_many(:ratings) }
  it { is_expected.to have_many(:addresses) }
  it { is_expected.to have_many(:credit_cards) }

  describe "validates uniqueness of an email" do
    subject { FactoryGirl.build(:customer) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

end
