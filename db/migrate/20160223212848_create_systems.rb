class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.string :name
      t.text :ubication
      t.references :area, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
