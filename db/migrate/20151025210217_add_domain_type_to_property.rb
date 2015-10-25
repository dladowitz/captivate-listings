class AddDomainTypeToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :domain_type, :string
    add_column :properties, :domain, :string
  end
end
