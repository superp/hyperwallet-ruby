module Hyperwallet
  class PaypalAccount < HyperwalletObject

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
