class CreateMasses < ActiveRecord::Migration[5.2]
  def change
    create_table :masses do |t|
      t.string :day
      t.string :schedule
      t.string :priest
      t.references :church, null: false
      t.timestamps

    end
    add_index :masses, :church, unique: true
    add_foreign_key :masses, :churches, column: :church_id
    
  end
end
