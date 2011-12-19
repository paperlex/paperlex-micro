class AddSlawInfo < ActiveRecord::Migration
  def up
    add_column :contracts, :slaw_uuid, :string
  end

  def down
  end
end
