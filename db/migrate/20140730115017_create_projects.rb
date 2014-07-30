class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
	  t.belongs_to :user
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
