class Company < ApplicationRecord
  has_rich_text :description

  validates_format_of :email, with: /\b[A-Z0-9._%a-z\-]+@getmainstreet\.com\z/, allow_blank: true, message: "Domain name is not matching"

  before_save :get_city_and_state, if: :zip_code_changed?

  def get_city_and_state
    zipcode = Zipcode.find_by_code self.zip_code
    if zipcode.present?
      self.city = data[:city]
      self.state = data[:state]
    end
  end
end
