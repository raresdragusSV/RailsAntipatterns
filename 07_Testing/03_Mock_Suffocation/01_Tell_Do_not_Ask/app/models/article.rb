class Article < ActiveRecord::Base
  MIN_VOTES_TO_DISPLAY = 4
  FEATURED_CUTOFF_AGE = 7.days

  scope :with_at_least_one_comment,
        where('articles.comments_count > 0')

  def with_votes_at_least(minimum)
    where(['articles.votes_count >= ?', minimum])
  end

  def created_after(cutoff_date)
    where(['articles.created_at > ?', cutoff_date])
  end

  def self.featured
    with_at_least_one_comment.with_votes_at_least(
      MIN_VOTES_TO_DISPLAY
    ).created_after(FEATURED_CUTOFF_AGE.ago)
  end
end
