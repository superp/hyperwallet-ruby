module Hyperwallet
  class Program < HyperwalletObject

    def self.find(program_key)
      res = Hyperwallet.request(:get, "/programs/#{program_key}")
      convert_to_hyperwallet_object(res, Program)
    end

    class Account < HyperwalletObject

      def self.find(program_key, account_key)
        res = Hyperwallet.request(:get, "/programs/#{program_key}/accounts/#{account_key}")
        convert_to_hyperwallet_object(res, Account)
      end

      def self.balances(program_key, account_key)
        res = Hyperwallet.request(:get, "/programs/#{program_key}/accounts/#{account_key}/balances")
        convert_to_hyperwallet_object(res, Account)
      end

    end
  end
end
