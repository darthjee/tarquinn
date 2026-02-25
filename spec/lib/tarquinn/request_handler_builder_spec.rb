# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::RequestHandlerBuilder do
  describe '#build' do
    let(:controller) do
      double('controller')
    end

    it do
      expect(subject.build(controller)).to be_a(Tarquinn::RequestHandler)
    end
  end

  describe "#add_redirection_config" do
    context "when calling for aredirection for the first time" do
      it "creates a new redirection config" do
        expect(subject.add_redirection_config(:redirection_path)).to be_a(Tarquinn::RedirectionConfig)
      end
    end

    context "when calling for an already defined redirection" do
      before do
        subject.add_redirection_config(:redirection_path)
      end

      it "raises an error" do
        expect { subject.add_redirection_config(:redirection_path) }
          .to raise_error(Tarquinn::Exception::RedirectionAlreadyDefined)
      end
    end

    xcontext "when calling for an already defined redirection by a skip rule" do
      before do
        subject.add_skip_config(:redirection_path)
      end

      it "raises an error" do
        expect { subject.add_redirection_config(:redirection_path) }
          .to raise_error(Tarquinn::Exception::RedirectionAlreadyDefined)
      end
    end
  end
end
