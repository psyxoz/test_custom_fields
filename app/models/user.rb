class User < ApplicationRecord
  include CustomFields

  custom_fields name:   :text_field,
                age:    :number_field,
                gender: :single_select,
                roles:  :multiple_select
end
