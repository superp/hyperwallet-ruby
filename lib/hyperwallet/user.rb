module Hyperwallet
  class User < HyperwalletObject

    def self.all(params={})
      res = Hyperwallet.request(:get, '/users', params)
      convert_to_hyperwallet_object(res, User)
    end

    def self.find(key)
      res = Hyperwallet.request(:get, "/users/#{key}")
      convert_to_hyperwallet_object(res, User)
    end

    def self.create(params={})
      res = Hyperwallet.request(:post, '/users', params)
      convert_to_hyperwallet_object(res, User)
    end

    def self.update(key, params)
      res = Hyperwallet.request(:put, "/users/#{key}", params)
      convert_to_hyperwallet_object(res, User)
    end

    def self.balances(key, params={})
      res = Hyperwallet.request(:get, "/users/#{key}/balances", params)
      convert_to_hyperwallet_object(res)
    end

    class PaypalAccount < HyperwalletObject

      def self.all(user_token, params)
        res = Hyperwallet.request(:get, "/users/#{user_token}/paypal-accounts", params)
        convert_to_hyperwallet_object(res, PaypalAccount)
      end

      def self.find(user_token, account_token)
        res = Hyperwallet.request(:get, "/users/#{user_token}/paypal-accounts/#{account_token}")
        convert_to_hyperwallet_object(res, PaypalAccount)
      end

      def self.create(user_token, params)
        res = Hyperwallet.request(:post, "/users/#{user_token}/paypal-accounts", params)
        convert_to_hyperwallet_object(res, PaypalAccount)
      end

      def self.update(user_token, account_token, params)
        res = Hyperwallet.request(:put, "/users/#{user_token}/paypal-accounts/#{account_token}", params)
        convert_to_hyperwallet_object(res, PaypalAccount)
      end

    end

  end
end
