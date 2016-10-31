User.create! name: "Admin", email: "huyennm195@gmail.com",
  password: "123456", password_confirmation: "123456",
  phone: "0123456789", admin: true,
  activated: true, activated_at: Time.zone.now

User.create! name: "Customer", email: "test@gmail.com",
  password: "123456", password_confirmation: "123456",
  phone: "0123456789", activated: true, activated_at: Time.zone.now
