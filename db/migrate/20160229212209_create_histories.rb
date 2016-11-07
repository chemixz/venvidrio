class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.date :date
      t.text :description
      t.string :unmounted_to
      t.string :installed_to
      t.string :install_by
      t.text :notes
      t.references :engine, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
