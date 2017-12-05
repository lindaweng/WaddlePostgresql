class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
        t.string :name
        t.string :age
        t.string :email
        t.string :username
        t.string :password
        t.string :waddles, array: true, default: []
        t.timestamps null: false
      end
  end
end
