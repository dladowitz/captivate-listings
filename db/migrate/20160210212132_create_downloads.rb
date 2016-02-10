class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.references :property, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :disclosure, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
