class AddCustomDomainToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :custom_domain, :string
  end
end
