class AddReviewSessions < ActiveRecord::Migration
  def up
    add_column :contracts, :review_session_1, :string
    add_column :contracts, :review_session_2, :string
  end

  def down
  end
end
