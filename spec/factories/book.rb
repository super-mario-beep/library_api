FactoryBot.define do
  let(:author) { create(:author) }
  
  factory :book do
    title { 'Don Quixote' }
    copies { 4 }
    author_id { author.id }
  end
end