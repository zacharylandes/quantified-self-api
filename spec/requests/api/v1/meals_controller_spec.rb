require "rails_helper"

describe "Meals API" do
  before :each do
    Food.destroy_all
    Meal.destroy_all
    @food = Food.create!(name: "Blueberry Muffin", calories: 250)
    @meal = Meal.create!(name: "Breakfast")
  end

  describe "#index" do
    it "returns all the meals" do
      get "/api/v1/meals"

      json_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json_response.first["id"]).to eq(@meal.id)
      expect(json_response.first["name"]).to eq(@meal.name)
    end
  end

  describe "#show" do
    context "finds the meal and food" do
      it "returns the meal and associated foods" do
        @meal.foods << @food
        get "/api/v1/meals/#{@meal.id}/foods"

        json_response = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(json_response["id"]).to eq(@meal.id)
        expect(json_response["name"]).to eq(@meal.name)
        expect(json_response["foods"].first["id"]).to eq(@food.id)
      end
    end

    context "unknown meal and/or food" do
      it "adds a food to a meal's collection" do
        @meal.foods << @food
        get "/api/v1/meals/900/foods"

        expect(response.status).to eq(404)
      end
    end
  end

  describe "#create" do
    context "finds the meal and food" do
      it "adds a food to a meal's collection" do
        post "/api/v1/meals/#{@meal.id}/foods/#{@food.id}"

        expect(response.status).to eq(201)
        expect(@meal.foods).to include(@food)
      end
    end

    context "unknown meal and/or food" do
      it "adds a food to a meal's collection" do
        post "/api/v1/meals/900/foods/900"

        expect(response.status).to eq(404)
        expect(@meal.foods).to_not include(@food)
      end
    end
  end

  describe "#destroy" do
    context "finds the meal and food" do
      it "removes a food to a meal's collection" do
        @meal.foods << @food
        delete "/api/v1/meals/#{@meal.id}/foods/#{@food.id}"

        @meal.reload
        expect(response.status).to eq(200)
        expect(@meal.foods).to_not include(@food)
      end
    end

    context "unknown meal and/or food" do
      it "adds a food to a meal's collection" do
        post "/api/v1/meals/900/foods/900"

        expect(response.status).to eq(404)
        expect(@meal.foods).to_not include(@food)
      end
    end
  end
end
