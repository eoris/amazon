require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the RatingsHelper. For example:
#
# describe RatingsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe RatingsHelper, type: :helper do

  describe "#avg_rating" do
    before { @book = FactoryGirl.create(:book) }

    it "should calculate average rating properly" do
      [10, 9, 9].each do |r|
        FactoryGirl.create(:rating, rating: r, book: @book)
      end
      expect(avg_rating(@book)).to eq(9.33)
    end

  end

end
