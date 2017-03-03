def test_user_without_posts_should_return_false_on_has_posted
  user = users(:bob)
  assert !user.has_posted?
end

def test_user_without_posts_should_not_be_allowed_to_edit_post
  user = users(:bob)
  post = posts(:political_post)
  assert !post.editable_by?(user)
end

def test_user_with_posts_return_true_on_has_posted
  user = users(:sarah)
  assert user.has_posted?
end

def test_user_posts_should_be_allowed_to_edit_own_post
  post = posts(:political_post)
  user = users(:sarah)
  assert post.editable_by?(user)
end

def test_admin_user_should_be_allowed_to_edit_other_users_post
  post = posts(:political_post)
  user = users(:charlie)
  assert post.editable_by?(user)
end

# refactoring

def test_user_without_posts_should_return_false_on_has_posted
  user = User.create!(name: 'Bob')
  assert !user.has_posted?
end

def test_user_without_posts_should_not_be_allowed_to_edit_post
  user = User.create!(name: 'Bob')
  assert !Post.create!(title: 'A post').editable_by?(user)
end

def test_user_with_posts_return_true_on_has_posted
  post = Post.create!(title: 'A post')
  user = User.create!(name: 'Bob', post: post)
  assert user.has_posted?
end

def test_user_posts_should_be_allowed_to_edit_own_post
  post = Post.create!(title: 'A post')
  user = User.create!(name: 'Bob', post: post)
  assert post.editable_by?(user)
end

def test_admin_user_should_be_allowed_to_edit_other_users_post
  user = User.create!(name: 'Bob', admin: true)
  assert !Post.create!(title: 'A post').editable_by?(user)
end

# using contexts

context 'A user' do
  setup { @user = User.create!(name: 'Bob') }

  should "not be allowed to edit another user's post" do
    @post = Post.create!(title: 'A Post')
    assert !@post.editable_by?(@user)
  end

  should 'return false on #has_posted?' do
    assert !@user.has_posted?
  end

  context 'with a post' do
    setup { @post = Post.create!(title: 'A Post', user: @user) }

    should 'be allowed to edit the post' do
      assert @post.editable_by?(@user)
    end

    should 'return true on #has_posted?' do
      assert @user.has_posted?
    end
  end

  context 'with admin privileges' do
    setup { @user.update_attributes!(admin: true) }

    should "be allowed to edit another user's post" do
      @post = Post.create!(title: 'A Post')
      assert @post.editable_by?(@user)
    end
  end
end

# using factories

context 'A user' do
  setup { @user = Factory(:user) }

  should "not be allowed to edit another user's post" do
    assert !Factory(:post).editable_by?(@user)
  end

  should 'return false on #has_posted?' do
    assert !@user.has_posted?
  end

  context 'with a post' do
    setup { @post = Factory(:post, user: @user) }

    should 'be allowed to edit the post' do
      assert @post.editable_by?(@user)
    end

    should 'return true on #has_posted?' do
      assert @user.has_posted?
    end
  end

  context 'with admin privileges' do
    setup { @user.update_attributes(admin: true) }

    should "be allowed to edit another user's post" do
      assert Factory(:post).editable_by?(@user)
    end
  end
end
