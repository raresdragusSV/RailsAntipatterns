class ArticlesController < ApplicationController
  def index
    @featured_articles =
      Article.with_at_least_one_comment
             .with_votes_at_least(
               Article::MIN_VOTES_TO_DISPLAY
             )
             .created_after(Article::FEATURED_CUTOFF_AGE.ago)
  end
end

# refactoring

class ArticlesController < ApplicationController
  def index
    @featured_articles = Article.featured
  end
end
