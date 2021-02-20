# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

TAGS = %w(Lead HighValue Finalized Stage2 LowValue Churned RealEstate)

if Rails.env.development?

    Tagging.destroy_all
    Tag.destroy_all
    Contact.destroy_all

  contacts = []
  tags = []

 puts '-- Create contacts --'

  10.times do |i|
    contacts << FactoryBot.create(:contact)
  end

 puts '-- Create tags --'

  TAGS.each do | tag |
    tags << FactoryBot.create(:tag, name: tag )
  end

  puts '-- Create taggings --'
  contacts.each do  |contact|
    rand(1..3).times do
      Tagging.find_or_create_by(contact_id: contact.id, tag_id: tags.sample.id)
    end
  end

  puts '-- Seeding completed --'


end
