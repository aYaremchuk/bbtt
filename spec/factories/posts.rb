FactoryBot.define do
  factory :post do
    user
    title { 'something' }
    text { 'something text' }
  end
end
