class CreateMasses < ActiveRecord::Migration[5.2]
  def change
    create_table :masses do |t|
      t.string :day
      t.string :schedule
      t.string :priest
      t.references :church, null: false
      t.timestamps

    end      
  end
end
