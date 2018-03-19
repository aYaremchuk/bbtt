namespace :db do
  desc 'Fill database with user'
  task fill_user: :environment do
    User.create(email: 'test@test.com', password: '12345678')
  end
end