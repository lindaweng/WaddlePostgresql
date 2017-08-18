class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
        t.string :location
        t.string :destination
        t.string :date
        t.string :time
        t.string :penguins
        t.timestamps null: false
    end
  end
end