class GatewayTest < Test::Unit::TestCase
  
  context "a new gateway" do
    
    setup do
      @gateway = ::Trademe::Gateway.new
    end
    
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

    context "with stubbed response" do
      setup do
        Net::HTTP.expects(:get).with("api.trademe.co.nz", "/v1/Search/Property/Residential.json?search_string=nice&date_from=2010-11-03T05%3A29%3A02.0Z").returns(open_mock("listing_search.json"))
      end
      
      should "accept a time arguement, correctly parse into a date string and then return listing array" do
        res = @gateway.search "property/residential", :search_string => "nice", :date_from => Time.parse("Wed, 03 Nov 2010 05:29:02 UTC 00:00")
        setup = Yajl::Parser.new.parse(open_mock("listing_search.json"))["List"].map{|hash| Trademe::Models::Listing.new(hash) }
        
        assert res.map{|l| l.id } == setup.map{|l| l.id }
        
        assert res.first.address_as_string == "46 Highbury Drive Levin, Levin, Horowhenua, Manawatu / Wanganui, New Zealand"
      end
    end
    
    context "with stubbed bad response" do
      setup do
        Net::HTTP.expects(:get).with("api.trademe.co.nz", "/v1/Search/Property/Residential.json?search_string=nice&date_from=2010-11-03T05%3A29%3A02.0Z").returns(open_mock("bad_response.json"))
      end
      
      should "raise an exception" do
        assert_raises Trademe::TrademeApiError do
          @gateway.search "property/residential", :search_string => "nice", :date_from => Time.parse("Wed, 03 Nov 2010 05:29:02 UTC 00:00")
        end
      end
    end
    
    context "with stubbed garbled response" do
      setup do
        Net::HTTP.expects(:get).with("api.trademe.co.nz", "/v1/Search/Property/Residential.json?search_string=nice&date_from=2010-11-03T05%3A29%3A02.0Z").returns("afdasfagag")
      end
      
      should "raise an exception" do
        assert_raises Trademe::TrademeApiError do
          @gateway.search "property/residential", :search_string => "nice", :date_from => Time.parse("Wed, 03 Nov 2010 05:29:02 UTC 00:00")
        end
      end
    end

  end
  
end