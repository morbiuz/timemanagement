class AddProviderAndUidToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :provider, :string
  	add_column :users, :uid, :decimal
  end
end
