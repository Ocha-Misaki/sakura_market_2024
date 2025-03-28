class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_one :address, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :restrict_with_error
  has_many :order_items, through: :orders
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  scope :default_order, -> { order(id: :asc) }
end
