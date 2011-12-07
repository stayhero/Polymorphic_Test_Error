class CreateDesigners < ActiveRecord::Migration
  def change
    create_table :designers do |t|
      t.string :favorite_color

      t.timestamps
    end
  end
end
