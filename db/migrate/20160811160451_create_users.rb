class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, default: ''
      t.integer :age
      t.string :occupation, default: ''
      t.date :birthdate

      t.timestamps null: false
    end
  end
end
