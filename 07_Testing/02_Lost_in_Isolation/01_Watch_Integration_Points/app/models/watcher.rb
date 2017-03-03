class Watcher < ActiveRecord::Base
  belongs_to :post

  def self.notify_all_of_published_post
    # ...
  end
end
