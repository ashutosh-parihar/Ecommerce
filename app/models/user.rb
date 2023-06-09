class User < ApplicationRecord
  rolify

  has_many :carts
  has_many :orders
  has_many :cart_items, through: :carts
  has_many :products, through: :cart_items, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :phone, presence: true
  validates :address, presence: true
end
