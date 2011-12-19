class AddSigners < ActiveRecord::Migration
  def up
    add_column :contracts, :signer_1, :string
    add_column :contracts, :signer_2, :string
  end

  def down
  end
end
