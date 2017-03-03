class ArticlesControllerTest < ActionController::TestCase
  context 'given featured articles' do
    setup do
      chain = stub('chain')
      @featured_articles = [Factory(:article), Factory(:article)]
      Article.stubs(:with_at_least_comment).returns(chain)
      chain.stubs(:with_votes_at_least)
           .with(
             Article::MIN_VOTES_TO_DISPLAY
           )
           .returns(chain)
      chain.stubs(:created_after)
           .with(
             Article::FEATURED_CUTOFF_AGE.ago
           )
           .returns(@featured_articles)
    end

    context 'on GET index' do
      setup { get :index }
      should assign_to(:featured_articles).with { @featured_articles }
    end
  end
end

# refactoring

class ArticlesControllerTest < ActionController::TestCase
  context 'given featured articles' do
    setup do
      @featured_articles = [Factory(:article), Factory(:article)]
      Article.stubs(:featured).returns(@featured_articles)
    end

    context 'on GET index' do
      setup { get :index }
      should assign_to(:featured_articles).with { @featured_articles }
    end
  end
end
