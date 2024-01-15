module CustomFields
  extend ActiveSupport::Concern

  module ClassMethods
    def custom_fields(*fields)
      return if fields.blank?
      return if local_stored_attributes&.[](:custom_fields).present?

      differences = fields - CustomField.pluck(:label).map(&:to_sym)
      raise "Unknown custom fields: #{differences.join(', ')}" if differences.present?

      store :custom_fields, accessors: fields
      custom_fields_storage = CustomField.where(label: fields).group_by(&:label).to_h

      fields.each do |attribute|
        custom_field = custom_fields_storage[attribute.to_s].first

        validators = {}
        if custom_field.text_field?
          validators[:format] = { with: /[a-zA-Z]/ }
        elsif custom_field.number_field?
          validators[:numericality] = true
        elsif custom_field.select_field?
          validators[:inclusion] = { in: custom_field.field_value }
        end

        validates(attribute, **validators) if validators.present?
      end
    end
  end
end
