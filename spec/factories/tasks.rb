FactoryBot.define do
  factory :task do
    name { "test_write" }
    description { "Rspec&Capybara&FactoryBotを準備する" }
    association :user
  end
end
