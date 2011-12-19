class AddSignerUuid < ActiveRecord::Migration
  def up
    add_column :signatures, :signer_uuid, :text
  end

  def down
  end
end
