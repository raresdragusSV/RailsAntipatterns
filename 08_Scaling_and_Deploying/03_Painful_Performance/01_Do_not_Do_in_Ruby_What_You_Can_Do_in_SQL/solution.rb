@article.comments.count
@article.comments.length
@article.comments.size

@account = Account.find(3)
@users = @account.users.sort { |a, b| a.name.downcase <=> b.name.downcase }.first(5)

# refactoring

@users = @account.users.order('LCASE(name)').limit(5)
# SELECT * FROM users WHERE account_id = '3' ORDER BY LCASE(name)
# LIMIT 5

class User < ActiveRecord::Base
  has_many :comments
  has_many :articles, through: :comments

  def collaborators
    articles.collect(&:users).flatten.uniq.reject { |u| u == self }
  end
end

class Article < ActiveRecord::Base
  has_many :comments
  has_many :users, through: :comments
end

class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
end

class User < ActiveRecord::Base
  has_many :comments
  has_many :articles, through: :comments

  def collaborators
    User.select('DISTINCT users.*')
        .joins(comments: [:user, { article: :comments }])
        .where('articles.id in ? AND users.id != ?',
               article_ids, id)
  end
end

# SELECT DISTINCT users.* FROM users
# INNER JOIN comments
# ON comments.user_id = users.id
# INNER JOIN users users_comments
# ON users_comments.id = comments.user_id
# INNER JOIN articles
# ON articles.id = comments.article_id
# INNER JOIN comments comments_articles
# ON comments_articles.article_id = articles.id
# WHERE (articles.id in (1) AND users.id != 1)
