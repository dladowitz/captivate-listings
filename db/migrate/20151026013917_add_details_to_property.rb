class AddDetailsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :details, :hstore
    add_index :properties, :details, using: :gin
  end
end
