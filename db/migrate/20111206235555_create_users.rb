class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.integer  :typeable_id
      t.string   :typeable_type
      t.references :department

      t.timestamps
    end
  end
end
