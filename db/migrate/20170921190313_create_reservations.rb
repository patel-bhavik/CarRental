class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :car, index: true
      t.belongs_to :user, index: true
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
