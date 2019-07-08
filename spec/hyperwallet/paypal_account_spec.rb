require 'spec_helper'

describe Hyperwallet::PaypalAccount do

  let!(:api) { Hyperwallet.mock_rest_client = double('RestClient') }
  let!(:paypal_account_attrs) { TestData.paypal_account }

  describe ".create" do
    it "should call the api" do
      user_token = "usr-#{SecureRandom.uuid}"
      json = MultiJson.dump(paypal_account_attrs)

      expect(api).to receive(:post)
        .with(Hyperwallet.api_url("/users/#{user_token}/paypal-accounts"), nil, json)
        .and_return(test_response(paypal_account_attrs))

      Hyperwallet::PaypalAccount.create(user_token, paypal_account_attrs)
    end
  end

  describe ".update" do
    it "should call the api" do
      user_token = "usr-#{SecureRandom.uuid}"
      paypal_token = "trm-#{SecureRandom.uuid}"
      json = MultiJson.dump(paypal_account_attrs)

      expect(api).to receive(:put)
        .with(Hyperwallet.api_url("/users/#{user_token}/paypal-accounts/#{paypal_token}"), nil, json).
        and_return(test_response(paypal_account_attrs))

      Hyperwallet::PaypalAccount.update(user_token, paypal_token, paypal_account_attrs)
    end
  end

end
