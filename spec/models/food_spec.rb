require 'rails_helper'

RSpec.describe Food, type: :model do
  describe "validations" do
    context "valid" do
      it "with a name and calories" do
        food = Food.new(name: "Blueberry Muffin", calories: 250)
        expect(food).to be_valid
      end
    end

    context "invalid" do
      it "without a name" do
        food = Food.new(calories: 250)
        expect(food).to be_invalid
      end

      it "without calories" do
        food = Food.new(name: "Blueberry Muffin")
        expect(food).to be_invalid
      end
    end
  end
end
