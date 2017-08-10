require 'rails_helper'

RSpec.describe MealFood, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:meal)}
    it { is_expected.to belong_to(:food)}
  end
end
