require "rails_helper"

describe "Foods API" do
  before :each do
    Food.destroy_all
    @blueberry_muffin = Food.create!(name: "Blueberry Muffin", calories: 250)
    @grapes = Food.create!(name: "Grapes", calories: 40)
  end

  describe "#index" do
    it "returns all foods" do
      get "/api/v1/foods"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.length).to eq(2)
    end
  end

  describe "#show" do
    context "valid id" do
      it "returns the specific food requested" do
        get "/api/v1/foods/#{@blueberry_muffin.id}"

        json = JSON.parse(response.body)

        expect(response).to be_success
        expect(json["id"]).to eq(@blueberry_muffin.id)
        expect(json["name"]).to eq(@blueberry_muffin.name)
        expect(json["calories"]).to eq(@blueberry_muffin.calories)
      end
    end

    context "invalid id" do
      it "returns the specific food requested" do
        get "/api/v1/foods/NotFoundId"

        json = JSON.parse(response.body)
        expect(response.status).to eq(404)
      end
    end
  end

  describe "#create" do
    context "valid attributes" do
      it "creates the food" do
        post "/api/v1/foods", {food: {name: "Blueberry Muffin", calories: 250}}

        json = JSON.parse(response.body)
        expect(response).to be_success
        expect(Food.last.name).to eq("Blueberry Muffin")
        expect(Food.last.calories).to eq(250)
      end
    end

    context "invalid attributes" do
      it "fails to create the food without a name" do
        post "/api/v1/foods", {food: {calories: 250}}

        json = JSON.parse(response.body)
        expect(response.status).to eq(400)
        expect(json["name"].first).to eq("can't be blank")
      end
    end
  end

  describe "#update" do
    context "valid attributes" do
      it "updates the food" do
        patch "/api/v1/foods/#{@blueberry_muffin.id}", {food: {name: "Strawberry Muffin", calories: 900}}
        food = Food.find(@blueberry_muffin.id)

        json = JSON.parse(response.body)
        expect(response).to be_success
        expect(food.name).to eq("Strawberry Muffin")
        expect(food.calories).to eq(900)
      end
    end

    context "invalid attributes" do
      it "fails to update the food if an attribute has been removed" do
        patch "/api/v1/foods/#{@blueberry_muffin.id}", {food: {calories: ""}}

        json = JSON.parse(response.body)
        expect(response.status).to eq(400)
        expect(json["calories"].first).to eq("can't be blank")
      end
    end
  end

  describe "#destroy" do
    it "deletes the food" do
      delete "/api/v1/foods/#{@blueberry_muffin.id}"

      expect(response.status).to eq(204)
      expect(response.body).to eq("")

      food = Food.find_by(id: @blueberry_muffin.id)
      expect(food).to be_nil
    end
  end
end
