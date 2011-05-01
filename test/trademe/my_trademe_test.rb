class MyTrademeTest < Test::Unit::TestCase
  
  context "a new gateway" do
    
    setup do
      @gateway = ::Trademe::Gateway.new
    end
  
    methods = {
      :my_trade_me_summary => nil,
      :sold_items => "Last45Days",
      :member_ledger => "Last45Days",
      :watchlist => "All",
      :delivery_addresses => nil
    }
    
    context "when not authenticated" do
      
      setup do
        assert !@gateway.authorized?
      end
      
      methods.each do |method, criteria|
        context "make #{method} request" do
          should "raise as not authenticated" do
            assert_raises Trademe::MustBeAuthenticated do
              @response = if criteria
                @gateway.send(method, criteria)
              else
                @gateway.send(method)
              end
            end
          end
        end
      end
    end
    
    context "when authenticated" do
      setup do
        @gateway.expects(:authorized?).at_least_once.returns(true)
        assert @gateway.authorized?
      end
      
      methods.each do |method, criteria|
        context "make #{method} request" do
          setup do
            success_response = Net::HTTPSuccess.new('foo', 200, 'Success')
            success_response.stubs(:body).returns("[]") # TODO: need to use the API to grab some test json and throw it in a mock.
            @gateway.consumer.expects(:request).at_least_once.returns(success_response)
            
            @response = if criteria
              @gateway.send(method, criteria)
            else
              @gateway.send(method)
            end
          end
          
          should "have a response" do
            assert @response == []
          end
        end
      end
    end
        
  end
  
end
