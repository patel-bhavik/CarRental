class CreateSuggestedCars < ActiveRecord::Migration[5.1]
  def change
    create_table :suggested_cars do |t|
      t.string :user_name
      t.string :manufacturer
      t.string :model
      t.string :style
      t.string :location
      t.string :status

      t.timestamps
    end
  end
end
