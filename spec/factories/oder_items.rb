FactoryBot.define do
  factory :oder_item do
    product { nil }
    quantity { 1 }
    order { nil }
    sell_price { "MyString" }
  end
end
