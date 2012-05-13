namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
  end
end

def make_users
  admin = User.create!(name:     "LeetKash",
                       email:    "leet@leet.com",
                       password: "foobar",
                       password_confirmation: "foobar",
                       interests: "action|adventure|epic|leet")
  admin.toggle!(:admin)
end
