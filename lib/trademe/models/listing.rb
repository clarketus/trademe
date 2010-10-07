module Trademe
  module Models
    class Listing
      
      attr_accessor :data
      
      def initialize(hash)
        @data = hash
      end
      
      def id
        @data["ListingId"]
      end

      def address
        @data["Address"]
      end

      def suburb
        @data["Suburb"]
      end

      def district
        @data["District"]
      end

      def region
        @data["Region"]
      end
      
      def country
        "New Zealand"
      end
      
      def address_as_string
        [address, suburb, district, region, country].join(", ")
      end
      
    end
  end
end