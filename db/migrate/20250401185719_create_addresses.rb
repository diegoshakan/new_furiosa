class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :cep
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
