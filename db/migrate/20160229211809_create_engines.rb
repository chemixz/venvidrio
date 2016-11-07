class CreateEngines < ActiveRecord::Migration
  def change
    create_table :engines do |t|
      t.string :serial
      t.string :code
      t.string :brand
      t.string :model
      t.float :hp
      t.float :kw
      t.string :frame
      t.integer :rpm
      t.float :hertz
      t.string :amperes
      t.float :sf
      t.string :back_r
      t.string :front_r
      t.string :mf
      t.string :volts
      t.text :part_c
      t.date :install_date
      t.references :system, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
