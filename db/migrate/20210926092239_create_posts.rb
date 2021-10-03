class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :content
      t.string :title
      t.string :post_image
      t.string :janle
      t.references :user, null: false, foreign_key: { on_delete: :cascade, on_update: :cascade }


      t.timestamps
    end
  end
end
