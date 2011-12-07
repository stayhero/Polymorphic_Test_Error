class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :favorite_software

      t.timestamps
    end
  end
end
