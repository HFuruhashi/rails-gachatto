class AddParentPostToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :parent_post, foreign_key: { to_table: :posts }
  end
end
