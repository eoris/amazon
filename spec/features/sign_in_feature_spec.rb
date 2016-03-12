require 'rails_helper'

RSpec.describe "Sign In", type: :feature do

  let(:customer) { create(:customer) }

  scenario "Customer sign in successfully via sign in form if registered" do
    visit new_customer_session_path
    within("#new_customer") do
      fill_in 'Email', with: customer.email
      fill_in 'Password', with: customer.password
    end
    click_button I18n.t('devise.sessions.new.sign_in')
    expect(page).not_to have_content I18n.t('header.sign_in')
    expect(page).to have_content I18n.t('header.sign_out')
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
  end

  scenario "Customer sign in unsuccessfully via sign in form if unregistered" do
    visit new_customer_session_path
    within("#new_customer") do
      fill_in 'Email', with: 'unregistered@customer.com'
      fill_in 'Password', with: 'password'
    end
    click_button I18n.t('devise.sessions.new.sign_in')
    expect(page).to have_content I18n.t('devise.failure.invalid')
    expect(page).to have_content I18n.t('devise.sessions.new.sign_in')
  end
end
