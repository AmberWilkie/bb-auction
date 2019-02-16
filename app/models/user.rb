class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :dolla_dolla_bill

  has_many :products, dependent: :destroy
  has_many :bids, dependent: :destroy

  def dolla_dolla_bill
    self.money = rand(1000...10000)
  end
end
