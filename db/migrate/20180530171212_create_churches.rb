class CreateChurches < ActiveRecord::Migration[5.2]
  def change
    create_table :churches do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :priest
      t.string :photo

      t.timestamps
    end
  end
end
