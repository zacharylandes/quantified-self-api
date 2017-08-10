require "rails_helper"

describe "Meals API" do
  before :each do
    Food.destroy_all
    Meal.destroy_all
    @food = Food.create!(name: "Blueberry Muffin", calories: 250)
    @meal = Meal.create!(name: "Breakfast")
  end

  describe "#create" do
    it "adds a food to a meal's collection" do
      post "/api/v1/meals/#{@meal.id}/foods/#{@food.id}"

      expect(response.status).to eq(201)
      expect(@meal.foods).to include(@food)
    end
  end

  describe "#destroy" do
    it "removes a food to a meal's collection" do
      @meal.foods << @food
      delete "/api/v1/meals/#{@meal.id}/foods/#{@food.id}"

      @meal.reload
      expect(response.status).to eq(200)
      expect(@meal.foods).to_not include(@food)
    end
  end
end
