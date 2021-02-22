require 'rails_helper'
require 'spec_helper'

RSpec.describe Contact, type: :model do
  context 'as a valid factory' do
    let(:contact) { create(:contact) }

    it { expect(contact).to be_valid }
  end

  context 'invalid email length' do
    let(:contact) { build(:contact, email: 'invalid') }

    it { expect { contact.validate! }.to raise_error ActiveRecord::RecordInvalid }
  end

  context 'email already taken' do
    let(:existing_contact) { create(:contact) }
    let(:contact) { build(:contact, email: existing_contact.email) }

    it { expect { contact.save! }.to raise_error ActiveRecord::RecordInvalid }
  end

  it 'includes users with contact with tag' do
    contact = create(:contact, first_name: 'beeWhoo')
    tag = create(:tag, name: 'MillionDollarDeal')
    tagging = create(:tagging, contact: contact, tag: tag)

    expect(Contact.search_by_tag(tag.name).pluck(:id)).to include(contact.id)
  end
end
