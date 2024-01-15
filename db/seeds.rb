# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

CustomField.create!([
  { label: :name, field_type: :text_field },
  { label: :age, field_type: :number_field },
  { label: :gender, field_type: :single_select, field_value: [:male, :female, :other] },
  { label: :roles, field_type: :multiple_select, field_value: [:user, :hr, :pm, :admin] }
])
