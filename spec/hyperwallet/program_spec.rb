require 'spec_helper'

describe Hyperwallet::Program do

  let!(:api) { Hyperwallet.mock_rest_client = double('RestClient') }
  let!(:program) { TestData.program }

  describe ".find" do
    it 'should call the api' do
      expect(api).to receive(:get)
        .with(Hyperwallet.api_url('/programs/program_token_1'), nil, nil)
        .and_return(test_response(program))
      Hyperwallet::Program.find('program_token_1')
    end
  end

  describe Hyperwallet::Program::Account do

    let!(:api) { Hyperwallet.mock_rest_client = double('RestClient') }
    let!(:account) { TestData.account }

    describe ".find" do
      it 'should call the api' do
        expect(api).to receive(:get)
          .with(Hyperwallet.api_url('/programs/program_token_1/accounts/account_token_1'), nil, nil)
          .and_return(test_response(account))
        Hyperwallet::Program::Account.find('program_token_1', 'account_token_1')
      end
    end

    describe ".balances" do
      it 'should call the api' do
        expect(api).to receive(:get)
          .with(Hyperwallet.api_url('/programs/program_token_1/accounts/account_token_1/balances'), nil, nil)
          .and_return(test_response(account))
        Hyperwallet::Program::Account.balances('program_token_1', 'account_token_1')
      end
    end

  end

end
