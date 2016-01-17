require 'rails_helper'

RSpec.describe Author, type: :model do

  it { is_expected.to have_db_column(:firstname) }
  it { is_expected.to have_db_column(:lastname) }
  it { is_expected.to have_db_column(:biography) }

  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }

  it { is_expected.to have_and_belong_to_many(:books)}

end
