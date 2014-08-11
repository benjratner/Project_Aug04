class AddStreamIdToTweet < ActiveRecord::Migration
  def change
  	add_column :tweets, :stream_id, :integer
  end
end
