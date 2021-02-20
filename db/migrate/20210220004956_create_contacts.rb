class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.citext :email, null: false, index: { unique: true }
      t.string :first_name
      t.string :last_name
      t.timestamps
    end
  end
end
