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
    
    methods.each do |method, criteria|
      context "#{method} make request" do
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
  
end
