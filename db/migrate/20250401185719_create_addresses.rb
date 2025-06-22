class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.string :zipcode
      t.string :state
      t.string :city
      t.string :neighborhood
      t.string :street
      t.string :number
      t.string :reference_point
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
