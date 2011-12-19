class AddTitle < ActiveRecord::Migration
  def up
    add_column :contracts, :title, :string
  end

  def down
  end
end
