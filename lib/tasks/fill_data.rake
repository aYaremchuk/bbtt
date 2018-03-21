namespace :db do
  desc 'Fill database with users'
  task fill_users: :environment do
    User.create(email: 'user@test.com', password: '12345678')
    User.create(email: 'admin@test.com', password: '12345678', role: 1)
  end
end
