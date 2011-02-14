class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.string :author
      t.string :summary
      t.string :content
      t.time :published
      t.integer :feed_id

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
