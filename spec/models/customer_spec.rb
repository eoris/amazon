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
  it { is_expected.to have_many(:credit_cards) }

  it { is_expected.to have_one(:billing_address) }
  it { is_expected.to have_one(:shipping_address) }


  describe "validates uniqueness of an email" do
    subject { FactoryGirl.build(:customer) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

context "#from_omniauth" do
  it "creates a new customer if one doesn't already exist" do
    expect(Customer.count).to eq(0)
    Customer.from_omniauth(omniauth_mock)
    expect(Customer.count).to eq(1)
  end

  it "retrieves an existing customer" do
    customer = create(:customer, provider: 'facebook', uid: '12345')
    oauth_hash = OmniAuth.config.add_mock(:facebook, {provider: 'facebook', uid: '12345', info: {
                                                      email: customer.email,
                                                      first_name: customer.firstname,
                                                      last_name: customer.lastname,
                                                      password: customer.password}})
    expect(customer).to eq(Customer.from_omniauth(oauth_hash))
  end
end

end
