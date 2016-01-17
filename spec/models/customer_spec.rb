require 'rails_helper'

RSpec.describe Customer, type: :model do

  it { is_expected.to have_db_column(:email) }
  it { is_expected.to have_db_column(:firstname) }
  it { is_expected.to have_db_column(:lastname) }
  it { is_expected.to have_db_column(:password) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }
  it { is_expected.to validate_presence_of(:password) }

  it { is_expected.to have_many(:orders) }
  it { is_expected.to have_many(:ratings) }

  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

end
