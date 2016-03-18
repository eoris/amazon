require 'rails_helper'

RSpec.describe 'routing to authors', type: :routing do
  it "routes /author/:id to authors#show" do
    expect(get('/authors/:id')).to route_to(
      controller: 'authors',
      action: 'show',
      id: ':id'
    )
  end
end
