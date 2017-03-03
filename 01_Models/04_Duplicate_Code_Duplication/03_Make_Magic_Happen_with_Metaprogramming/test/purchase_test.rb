class PurchaseTest < Test::Unit::TestCase
  context 'Given some Purchase of each status' do
    setup do
      %w(in_progress submitted approved shipped received canceled).each do |s|
        Factory(:purchase, status: s)
      end
    end

    context 'Purchase.all_in_progress' do
      setup { @purchases = Purchase.all_in_progress }

      should 'not be empty' do
        assert !@purchases.empty?
      end

      should 'return only in progress purchases' do
        @purchases.each do |purchase|
          assert purchase.in_progress?
        end
      end

      should 'return all in progress purchases' do
        expected = Purchase.all.select(&:in_progress?)
        assert_same_elements expected, @purchases
      end
    end
  end
end
