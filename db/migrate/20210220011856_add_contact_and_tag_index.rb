class AddContactAndTagIndex < ActiveRecord::Migration[6.1]
  def change
    add_index(:taggings, %i[contact_id tag_id], unique: true)
  end
end
