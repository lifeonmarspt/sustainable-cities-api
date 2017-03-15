# == Schema Information
#
# Table name: bmes
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Bme, type: :model do
  before :each do
    FactoryGirl.create(:bme, name: 'Z Bme')
    @category = create(:category)
    @bme = create(:bme, category: @category)
  end

  it 'Count on bme with default scope' do
    expect(Bme.count).to           eq(2)
    expect(Bme.all.second.name).to eq('Z Bme')
  end

  it 'Order by name asc' do
    expect(Bme.by_name_asc.first.name).to eq('A Bme')
  end

  it 'Common and scientific name validation' do
    @bme = Bme.new(name: '')

    @bme.valid?
    expect { @bme.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
  end

  it 'Fetch all bmes' do
    expect(Bme.fetch_all(nil).count).to eq(2)
  end
end