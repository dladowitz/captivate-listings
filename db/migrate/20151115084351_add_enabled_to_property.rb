class AddEnabledToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :enabled, :boolean, default: true, null: false
  end
end
