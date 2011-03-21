class AddFbsToUser < ActiveRecord::Migration
  def self.up
	execute "ALTER TABLE Users ADD fb_id bigint"
  end

  def self.down
	execute "ALTER TABLE Users DROP fb_id bigint"
  end
end
