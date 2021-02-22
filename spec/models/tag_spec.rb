require 'rails_helper'
require 'spec_helper'

RSpec.describe Tag, type: :model do


  context 'as a valid factory' do
    let(:tag) {create(:tag)}

    it { expect(tag).to be_valid}
  end

  context 'sanatizes camelCase before save' do
    let(:tag) {create(:tag, name: 'HelloWorld')}

    it { expect(tag.name).to eq('hello_world')}
  end


end
