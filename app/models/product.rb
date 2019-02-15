class Product < ApplicationRecord
  belongs_to :user, required: true
end
