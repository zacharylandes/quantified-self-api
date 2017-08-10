class Api::V1::MealsController < ApplicationController
  before_filter :find_meal, :find_food

  def create
    @meal.foods << @food

    render json: { message: "Successfully added #{@food.name} to #{@meal.name}"}, status: 201
  end

  def destroy
    meal_food = MealFood.find_by(meal: @meal, food: @food)
    meal_food.destroy

    render json: { message: "Successfully removed #{@food.name} from #{@meal.name}"}, status: 200
  end

  private

  def find_meal
    @meal ||= Meal.find(params[:meal_id])
  end

  def find_food
    @food ||= Food.find(params[:id])
  end
end
