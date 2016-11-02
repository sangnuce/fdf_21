User.create! name: "Admin", email: "admin@gmail.com",
  password: "123456", password_confirmation: "123456",
  phone: "0123456789", admin: true,
  activated: true, activated_at: Time.zone.now

User.create! name: "Customer", email: "customer@gmail.com",
  password: "123456", password_confirmation: "123456",
  phone: "0123456789", activated: true, activated_at: Time.zone.now

10.times do |n|
  name = "Category #{n}"
  classify = rand 0..1
  category = Category.create! name: name, classify: classify
  30.times do |i|
    name = "Product #{i} in category #{n}"
    price = (rand 1..200) * 1000
    quantity = rand 0..100
    description = Faker::Lorem.sentence 150
    category.products.create! name: name, price: price, quantity: quantity,
      description: description
  end
end
