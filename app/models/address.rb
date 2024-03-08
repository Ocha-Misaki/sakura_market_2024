class Address < ApplicationRecord
  belongs_to :user
  validates :address_name, presence: true
  validates :address, presence: true
end
