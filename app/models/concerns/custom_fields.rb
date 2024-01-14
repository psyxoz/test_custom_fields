module CustomFields
  extend ActiveSupport::Concern

  class_methods do
    def custom_fields(**attrs)
      return unless attrs
      return if local_stored_attributes&.[](:custom_fields).present?

      labels = attrs.values.map(&:to_s)
      differences = labels - CustomField.pluck(:label)
      raise "Unknown custom fields: #{differences.join(', ')}" if differences.present?

      store :custom_fields, accessors: attrs.keys
      custom_fields_storage = CustomField.where(label: labels).group_by(&:label).to_h

      attrs.each do |attribute, field_label|
        custom_field = custom_fields_storage[field_label]

        validators = {}
        if custom_field.text_field?
          validators[:format] = { with: /[a-zA-Z]/ }
        elsif custom_field.number_field?
          validators[:numericality] = true
        elsif custom_field.select_field?
          validators[:inclusion] = { in: custom_field.field_value }
        end

        validates(attribute.to_sym, **validators) if validators.present?
      end
    end
  end
end
