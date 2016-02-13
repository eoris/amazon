require 'rails_helper'

RSpec.describe Address, type: :model do

  it { is_expected.to have_db_column(:firstname) }
  it { is_expected.to have_db_column(:lastname) }
  it { is_expected.to have_db_column(:address) }
  it { is_expected.to have_db_column(:zipcode) }
  it { is_expected.to have_db_column(:city) }
  it { is_expected.to have_db_column(:phone) }
  it { is_expected.to have_db_column(:customer_id) }
  it { is_expected.to have_db_column(:country_id) }

  it { is_expected.to belong_to(:customer) }
  it { is_expected.to belong_to(:country) }

  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:zipcode) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:customer_id) }
  it { is_expected.to validate_presence_of(:country_id) }

end
