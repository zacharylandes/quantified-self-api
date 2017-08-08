foods = [
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

foods.each do |food|
  new_food = Food.create!(name: food.first, calories: food.last)
  puts "Created #{new_food.name}"
end
