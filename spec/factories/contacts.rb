FactoryBot.define do
  factory :contact, class: Contact do
    email { Faker::Internet.unique.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    before(:create) do |contact|
      contact.taggings << build(:tagging, contact: contact)
    end
  end
end
