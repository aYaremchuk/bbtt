class Connections < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :user, index: true

    create_join_table :groups, :users do |t|
      t.index %i(group_id user_id)
    end

    create_join_table :groups, :posts do |t|
      t.index %i(group_id post_id)
    end
  end
end
