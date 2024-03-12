class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :text, presence: true
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [300, 300]
    attachable.variant :thumbnail, resize_to_limit: [200, 200]
  end
  scope :default_order, -> { order(id: :desc) }
end
