FactoryBot.define do
  factory :book do
    title { 'Don Quixote' }
    copies { 4 }
    association :author
  end
end