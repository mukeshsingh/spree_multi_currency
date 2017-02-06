require 'spec_helper'

class FakesController < ApplicationController
  include Spree::Core::ControllerHelpers::Order
end

describe Spree::Core::ControllerHelpers::Order, type: :controller do
  controller(FakesController) {}

  before(:each) do
    allow(controller).to receive_messages(spree_current_user: nil)
    allow(request).to receive_messages(remote_ip: '51.255.166.247')
    reset_spree_preferences do |config|
      config.supported_currencies   = 'USD,EUR'
      config.allow_currency_change  = true
    end
  end

  describe '#current_user_country_currency' do
    let(:spree_current_user) { double('spree_current_user') }
    it 'returns current user country currency' do
      expect(controller.current_user_country_currency).to eq 'EUR'
    end
  end

  describe '#current_currency' do
    it 'returns current currency' do
      Spree::Config[:currency] = 'USD'
      expect(controller.current_currency).to eq 'EUR'
    end
  end
end
