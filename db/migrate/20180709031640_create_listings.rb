class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.belongs_to :user
      t.string :title
      t.string :description
      t.string :country
      t.integer :num_of_guests
      t.text :amenities, array: :true, default: []
      t.timestamps
    end
  end
end
