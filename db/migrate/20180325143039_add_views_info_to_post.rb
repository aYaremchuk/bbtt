class AddViewsInfoToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :views_info, :json, default: {}, null: false
  end
end
