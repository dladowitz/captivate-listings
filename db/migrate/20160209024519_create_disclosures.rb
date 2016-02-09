class CreateDisclosures < ActiveRecord::Migration
  def change
    create_table :disclosures do |t|
      t.string :title
      t.string :url
      t.string :car_form
      t.references :property, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
