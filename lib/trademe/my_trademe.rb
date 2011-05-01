module Trademe
  module MyTrademe
    def my_trade_me_summary(filters={})
      check_authentication
      
      url = "#{base_url}/MyTradeMe/Summary.#{@format}"
      url << "?#{urlize(filters)}" unless filters.empty?

      send_request(url)
    end
    
    def sold_items(criteria, filters={})
      check_authentication
      
      url = "#{base_url}/MyTradeMe/SoldItems/#{criteria}.#{@format}"
      url << "?#{urlize(filters)}" unless filters.empty?

      send_request(url)
    end
    
    def member_ledger(criteria, filters={})
      check_authentication
      
      url = "#{base_url}/MyTradeMe/MemberLedger/#{criteria}.#{@format}"
      url << "?#{urlize(filters)}" unless filters.empty?

      send_request(url)
    end
    
    def watchlist(criteria, filters={})
      check_authentication
      
      url = "#{base_url}/MyTradeMe/Watchlist/#{criteria}.#{@format}"
      url << "?#{urlize(filters)}" unless filters.empty?

      send_request(url)
    end
    
    def delivery_addresses
      check_authentication
      
      url = "#{base_url}/MyTradeMe/DeliveryAddresses.#{@format}"

      send_request(url)
    end
  end
end