class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text
      t.references :author, index: true

      t.timestamps
    end
    add_foreign_key :articles, :users, column: :author_id
  end
end
