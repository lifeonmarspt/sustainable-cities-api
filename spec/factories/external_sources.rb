# == Schema Information
#
# Table name: external_sources
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :text
#  web_url          :string
#  attacheable_type :string
#  attacheable_id   :integer
#  is_active        :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :external_source do
    name 'External source'
    web_url 'test-web.org'
    is_active true
    association :attacheable, factory: :study_case
  end
end