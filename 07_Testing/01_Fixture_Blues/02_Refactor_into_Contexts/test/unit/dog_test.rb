context 'A dog' do
  setup { @dog = Dog.new }

  should 'bark when sent #talk' do
    assert_equal 'bark', @dog.talk
  end

  context 'with fleas' do
    setup do
      @dog.fleas << Flea.new
      @dog.fleas << Flea.new
    end

    should 'scratch when idle' do
      @dog.idle!
      assert @dog.scratching?
    end

    should 'not be allowed inside' do
      assert !@dog.allowed_inside?
    end
  end
end
