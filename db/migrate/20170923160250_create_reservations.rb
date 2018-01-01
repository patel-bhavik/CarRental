class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.references :car, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :from
      t.datetime :to
      t.float :rental_charge

      t.timestamps
    end
  end
end
