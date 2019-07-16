require 'spec_helper'

describe Hyperwallet::User do

  let!(:api) { Hyperwallet.mock_rest_client = double('RestClient') }
  let!(:user) { TestData.user }

  describe ".all" do
    it "should call the api" do
      expect(api).to receive(:get)
        .with(Hyperwallet.api_url("/users"), nil, nil)
        .and_return(test_response([user]))
      Hyperwallet::User.all
    end
  end

  describe ".find" do
    it "should call the api" do
      expect(api).to receive(:get)
        .with(Hyperwallet.api_url("/users/user_token_1"), nil, nil)
        .and_return(test_response(user))
      Hyperwallet::User.find("user_token_1")
    end
  end

  describe ".create" do
    it "should call the api" do
      expect(api).to receive(:post)
        .with(Hyperwallet.api_url('/users'), nil, MultiJson.dump(user))
        .and_return(test_response(user))
      Hyperwallet::User.create(user)
    end
  end

  describe ".update" do
    it "should call the api" do
      expect(api).to receive(:put)
        .with(Hyperwallet.api_url("/users/user_token_1"), nil, "{\"firstName\":\"Jonathan\"}").
        and_return(test_response(user))
      Hyperwallet::User.update("user_token_1", :firstName => "Jonathan")
    end
  end

  describe ".balances" do
    it "should call the api" do
      expect(api).to receive(:get)
        .with(Hyperwallet.api_url("/users/user_token_1/balances"), nil, nil)
        .and_return(test_response(user))
      Hyperwallet::User.balances("user_token_1")
    end
  end

  describe Hyperwallet::User::PaypalAccount do

    let!(:api) { Hyperwallet.mock_rest_client = double('RestClient') }
    let!(:paypal_account_attrs) { TestData.paypal_account }

    describe ".create" do
      it "should call the api" do
        user_token = "usr-#{SecureRandom.uuid}"
        json = MultiJson.dump(paypal_account_attrs)

        expect(api).to receive(:post)
          .with(Hyperwallet.api_url("/users/#{user_token}/paypal-accounts"), nil, json)
          .and_return(test_response(paypal_account_attrs))

        Hyperwallet::User::PaypalAccount.create(user_token, paypal_account_attrs)
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

        Hyperwallet::User::PaypalAccount.update(user_token, paypal_token, paypal_account_attrs)
      end
    end

  end

end
