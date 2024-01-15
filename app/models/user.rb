class User < ApplicationRecord
  include CustomFields

  custom_fields :name, :age, :gender, :roles

  validates :email, presence: true, uniqueness: true
end
