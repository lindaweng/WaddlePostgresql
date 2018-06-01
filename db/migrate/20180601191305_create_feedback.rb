class CreateFeedback < ActiveRecord::Migration[5.1]
  def change
    create_table :feedback do |t|
        t.string :name
        t.string :email
        t.string :feedback
        t.timestamps null: false
      end
  end
end
