module Factory
  class << self
    def create_published_post
      post = Post.new(
        body: 'lorem ipsum',
        title: 'Published post title',
        published: true
      )
      post.save!
      post
    end

    def create_unpublished_post
      post = Post.new(
        body: 'lorem ipsum',
        title: 'Published post title',
        published: false
      )
      post.save!
      post
    end
  end
end


# using FactoryGirl gem

Factory.sequence :title { |n| "Title #{n}" }

Factory.define :post do |post|
  post.body "lorem ipsum"
  post.title { Factory.next(:title) }
  post.association :author, factory: :user
  post.published true
end
