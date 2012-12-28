class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips do |t|
      t.string :name
      t.text :paste
      t.references :user
      t.references :history

      t.timestamps
    end
    add_index :clips, :user_id
    add_index :clips, :history_id
  end
end
