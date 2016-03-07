class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockabley, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :orders
  has_many :ratings
  has_many :addresses
  has_many :credit_cards
  has_one  :shipping_address
  has_one  :billing_address

  validates :firstname, :lastname, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |customer|
      customer.firstname = auth.info.first_name
      customer.lastname = auth.info.last_name
      customer.email = auth.info.email
      customer.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |customer|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        customer.email = data["email"] if customer.email.blank?
      end
    end
  end

end
