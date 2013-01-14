class LinkOuser < ActiveRecord::Migration
  def change
    add_column :users, :ouser_id, :integer
    #add_index :persons, :body

#    add_column :persons, :pid, :integer
#    add_index :persons, :pid, :unique => true
  end

end
