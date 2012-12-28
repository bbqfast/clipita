class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.text :paste
      t.references :user

      t.timestamps
    end
    add_index :histories, :user_id
  end
end
