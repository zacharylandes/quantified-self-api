Food.destroy_all
Meal.destroy_all

FOODS = [
          ["Banana", 150],
          ["Bagel Bites - Four Cheese", 650],
          ["Chicken Burrito", 800],
          ["Grapes", 180],
          ["Blueberry Muffins", 450],
          ["Yogurt", 550],
          ["Macaroni and Cheese", 950],
          ["Granola Bar", 200],
          ["Gum", 50],
          ["Cheese", 400],
          ["Fruit Snacks", 120],
          ["Apple", 220]
        ]

MEALS = [ "Breakfast", "Snack", "Lunch", "Dinner" ]

FOODS.each do |food|
  new_food = Food.create!(name: food.first, calories: food.last)
  puts "Created #{new_food.name}"
end

MEALS.each do |meal_name|
  meal = Meal.create!(name: meal_name)
  puts "Created #{meal.name}"
end

Meal.all.each do |meal|
  3.times do
    random_id = rand(Food.first.id..Food.last.id)
    meal.foods << Food.find(random_id)
  end
end
