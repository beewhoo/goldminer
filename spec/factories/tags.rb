FactoryBot.define do
  factory :tag, class: Tag do
    name { Faker::Name.unique.name }
    initialize_with { Tag.find_or_create_by(name: name)}
  end
end
