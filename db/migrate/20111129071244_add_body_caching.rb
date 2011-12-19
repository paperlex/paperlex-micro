class AddBodyCaching < ActiveRecord::Migration
  def up
    add_column :contracts, :body, :text
  end

  def down
  end
end
