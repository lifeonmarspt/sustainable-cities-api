# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Find and create new seed files in db/fixtures
Rake::Task['db:seed_fu'].invoke

# Generate slugs for categories
if Category.where.not(slug: nil).size.zero?
  Category.all.each(&:save)
end

Rake::Task['update:category_levels'].invoke