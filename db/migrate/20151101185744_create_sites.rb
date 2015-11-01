class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.references :property, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
