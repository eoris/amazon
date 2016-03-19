OmniAuth.config.test_mode = true

def omniauth_mock
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    :provider => 'facebook',
    :uid => '123545',
    :info => { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email }
  })
end
