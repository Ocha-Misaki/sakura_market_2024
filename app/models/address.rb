class Address < ApplicationRecord
  belongs_to :user
  validates :address_name, presence: true
  validates :location, presence: true
end
