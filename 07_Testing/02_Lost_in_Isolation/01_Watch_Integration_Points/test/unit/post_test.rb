class PostTest < ActiveSupport::TestCase
  should_have_many :watchers

  context 'a post' do
    setup { @post = Factory(:post) }

    should 'send notify_all_of_published_post to its
watchers when published' do
      @post.watchers
           .expects(:notify_all_of_published_post)
           .with(@post)
      @post.publish!
    end
  end
end
