class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :text
      t.text :url
      t.text :screen_name
      t.text :img_url

      t.timestamps
    end
  end
end
