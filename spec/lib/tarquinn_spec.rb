# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn, type: :controller do
  describe '.redirection_rule' do
    context 'when there is only one condition' do
      controller(Tarquinn::DummyRouteController) do
        redirection_rule :redirection, :should_redirect?
      end

      before { get :index, params: parameters }

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

    # TODO: fix this condition
    context 'when there is only one block condition' do
      controller(Tarquinn::DummyRouteController) do
        redirection_rule :redirection do
          params[:redirect_block]
        end
      end

      before { get :index, params: parameters }

      context 'when request indicates a redirection' do
        let(:parameters) { { redirect_block: true } }

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

    context 'when there are more conditions' do
      controller(Tarquinn::DummyRouteController) do
        redirection_rule :redirection, :should_redirect?, :condition2
      end

      before { get :index, params: parameters }

      context 'when request indicates a redirection through first condition' do
        let(:parameters) { { should_redirect: true } }

        it 'performs a redirect' do
          expect(response).to redirect_to('/path')
        end
      end

      context 'when request indicates a redirection through second condition' do
        let(:parameters) { { redirect: true } }

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

    # TODO: fix this condition
    context 'when there are no conditions' do
      controller(Tarquinn::DummyRouteController) do
        redirection_rule :redirection
      end

      before { get :index }

      it 'performs a redirect' do
        expect(response).to redirect_to('/path')
      end
    end
  end

  describe '.skip_redirection' do
    context 'when there is only one skip condition' do
      controller(Tarquinn::DummyRouteController) do
        redirection_rule :redirection, :always_redirect
        skip_redirection_rule :redirection, :should_skip?
      end

      before { get :index, params: parameters }

      context 'when requesting with parameters that do not skip' do
        let(:parameters) { {} }

        it 'performs a redirect' do
          expect(response).to redirect_to('/path')
        end
      end

      context 'when request does not indicate a redirection' do
        let(:parameters) { { should_skip: true } }

        it 'does not performs a redirect' do
          expect(response).not_to redirect_to('/path')
        end
      end
    end

    context 'when there are more than oneskip condition' do
      controller(Tarquinn::DummyRouteController) do
        redirection_rule :redirection, :always_redirect
        skip_redirection_rule :redirection, :should_skip?, :do_skip?
      end

      before { get :index, params: parameters }

      context 'when requesting with parameters that do not skip' do
        let(:parameters) { {} }

        it 'performs a redirect' do
          expect(response).to redirect_to('/path')
        end
      end

      context 'when request skips redirection using first condition' do
        let(:parameters) { { should_skip: true } }

        it 'does not performs a redirect' do
          expect(response).not_to redirect_to('/path')
        end
      end

      context 'when request skips redirection using second condition' do
        let(:parameters) { { skip: true } }

        it 'does not performs a redirect' do
          expect(response).not_to redirect_to('/path')
        end
      end
    end
  end

  describe '.skip_redirection_rule' do
    controller(Tarquinn::DummyRouteController) do
      redirection_rule :redirection, :always_redirect
      skip_redirection :redirection, :index, :delete
    end

    before { get action }

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
