require 'rails_helper'

RSpec.describe Admin, type: :model do

  it { is_expected.to have_db_column(:email) }
  it { is_expected.to have_db_column(:encrypted_password) }
  it { is_expected.to have_db_column(:reset_password_token) }

end
