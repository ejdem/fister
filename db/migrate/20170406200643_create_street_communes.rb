class CreateStreetCommunes < ActiveRecord::Migration[5.0]
  def change
    create_table :street_communes do |t|
      t.references :street, foreign_key: true
      t.references :commune, foreign_key: true

      t.timestamps
    end
  end
end
