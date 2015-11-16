class RemoveColumnFromProperty < ActiveRecord::Migration
  def change
    remove_column :properties, :domain, :string
    remove_column :properties, :domain_type, :string
  end
end
