class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :licence_no
      t.string :manufacturer
      t.string :model
      t.string :style
      t.string :location
      t.float :hourly_rate
      t.string :status

      t.timestamps
    end
  end
end
