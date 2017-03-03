class PostTest < ActiveSupport::TestCase
  should 'find all published posts on Post.published' do
    Factory.create_published_post
    Factory.create_unpublished_post
    Post.pusblished.each do |post|
      assert post.published?
    end
  end
end

# using FactoryGirl gem

class PostTest < ActiveSupport::TestCase
  should 'find all published posts on Post.published' do
    Factory(:post)
    Factory(:post, published: false)
    Post.published.each do |post|
      assert post.published?
    end
  end
end
