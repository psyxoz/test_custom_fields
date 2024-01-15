class CustomField < ApplicationRecord
  enum :field_type, {
    text_field: 0,
    number_field: 1,
    single_select: 2,
    multiple_select: 3
  }

  validates :label, presence: true, uniqueness: true
  validate :validate_field_value, if: :select_field?

  def select_field?
    single_select? || multiple_select?
  end

  private

  def validate_field_value
    errors.add(:field_value, 'Should be an Array') unless field_value.is_a?(Array)
  end
end
