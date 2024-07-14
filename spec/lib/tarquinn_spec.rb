# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn, type: :controller do
  describe '.redirection_rule' do
    controller(Tarquinn::DummyRouteController) do
      redirection_rule :redirection, :should_redirect?
    end

    before do
      get :index, params: parameters
    end

    context 'when request indicates a redirection' do
      let(:parameters) { { should_redirect: true } }

      it 'performs a redirect' do
        expect(response).to redirect_to('/path')
      end
    end

    context 'when request does not indicate a redirection' do
      let(:parameters) { {} }

      it 'does not performs a redirect' do
        expect(response).not_to redirect_to('/path')
      end
    end
  end

  describe '.skip_redirection_rule' do
    controller(Tarquinn::DummyRouteController) do
      redirection_rule :redirection, :always_redirect
      skip_redirection :redirection, :index, :delete
    end

    before do
      get action
    end

    context 'when requestin a path that redirects' do
      let(:action) { :new }

      it 'performs a redirect' do
        expect(response).to redirect_to('/path')
      end
    end

    context 'when request does not indicate a redirection' do
      let(:action) { :index }

      it 'does not performs a redirect' do
        expect(response).not_to redirect_to('/path')
      end
    end
  end
end
