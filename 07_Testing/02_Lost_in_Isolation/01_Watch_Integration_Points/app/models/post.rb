class Post < ActiveRecord::Base
  has_many :watchers

  def publish!
    watchers.notify_all_of_published_post(self)
  end
end
