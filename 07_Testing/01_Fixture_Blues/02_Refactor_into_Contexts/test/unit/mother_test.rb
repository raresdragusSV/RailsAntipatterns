def test_get_to_show
  get :show, id: @mother.to_param
  assert_response :success
  assert_template :show
  assert_nil flash[:warning]
  assert assigns(:mother)
  assert assigns(:children)
  assigns(:children).each do |child|
    assert child.good?
  end
end

# using contexts

context 'on GET to #show' do
  setup { get :show, id: @mother.to_param }

  should 'respond successfully' do
    assert_response :success
  end

  should 'render the show template' do
    assert_template :show
  end

  should 'not set the flash' do
    assert_nil flash[:warning]
  end

  should 'assign to mother' do
    assert assigns(:mother)
  end

  should 'only show good children' do
    assert assigns(:children)
    assigns(:children).each do |child|
      assert child.good?
    end
  end
end
