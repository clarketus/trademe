class GatewayTest < Test::Unit::TestCase
  
  context "a new gateway" do
    
    setup do
      @gateway = ::Trademe::Gateway.new
    end
    
    # http://api.trademe.co.nz/v1/Search/Property/Residential.xml?search_string=nice
    context "with stubbed response" do
      setup do
        Net::HTTP.expects(:get).with("api.trademe.co.nz", "/v1/Search/Property/Residential.json?search_string=nice").returns(open_mock("listing_search.json"))
      end
      
      should "run search queries that return an array of listings" do
        res = @gateway.search "property/residential", :search_string => "nice"
        setup = Yajl::Parser.new.parse(open_mock("listing_search.json"))["List"].map{|hash| Trademe::Models::Listing.new(hash) }
        
        assert res.map{|l| l.id } == setup.map{|l| l.id }
        
        assert res.first.address_as_string == "46 Highbury Drive Levin, Levin, Horowhenua, Manawatu / Wanganui, New Zealand"
      end
    end

  end
  
end