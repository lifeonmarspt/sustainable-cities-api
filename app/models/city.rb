# frozen_string_literal: true
# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string
#  country_id :integer
#  lat        :decimal(, )
#  lng        :decimal(, )
#  province   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ApplicationRecord
  belongs_to :country, inverse_of: :cities

  has_many :users, inverse_of: :city

  validates :name, presence: true

  scope :by_name_asc, -> { order('cities.name ASC') }

  default_scope { by_name_asc }

  class << self
    def fetch_all(options)
      all
    end

    def city_select
      by_name_asc.map { |c| [c.name, c.id] }
    end
  end
end