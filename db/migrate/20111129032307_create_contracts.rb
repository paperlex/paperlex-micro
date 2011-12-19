class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :uuid
      
      t.string :email_1
      t.string :email_2
      
      t.text :responses
      
      t.timestamps
    end
  end
end
