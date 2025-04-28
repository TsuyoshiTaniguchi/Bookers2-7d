class AddTagsToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :tags, :string
  end
end
