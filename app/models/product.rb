class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many_attached :images, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  validates :name, presence: true
  validates :actual_price, presence: true
  validates :current_price, presence: true
  validates :images, presence: true
  validates :description, presence: true
end
