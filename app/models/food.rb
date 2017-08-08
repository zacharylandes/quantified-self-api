class Food < ApplicationRecord
  validates :name, :calories, presence: true
end
