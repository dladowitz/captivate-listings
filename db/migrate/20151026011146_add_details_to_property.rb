class AddDetailsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :details, :hstore
  end
end
