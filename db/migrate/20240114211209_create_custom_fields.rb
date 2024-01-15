class CreateCustomFields < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_fields do |t|
      t.string :label
      t.integer :field_type, default: 0, limit: 2
      t.json :field_value
      t.timestamps
    end

    add_index :custom_fields, :label, unique: true
  end
end
