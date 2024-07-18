# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::Condition::ProcRunner do
  let(:rails_controller) { rails_controller_class.new }
  let(:controller) { Tarquinn::Controller.new(rails_controller) }
  let(:subject) { described_class.new(&block) }
  let(:rails_controller_class) do
    Class.new(ActionController::Base)
  end

  describe '#check?' do
    context 'when block evaluates into true' do
      let(:block) { proc { true } }

      it do
        expect(subject.check?(controller)).to be_truthy
      end
    end

    context 'when block evaluates into false' do
      let(:block) { proc { false } }

      it do
        expect(subject.check?(controller)).to be_falsey
      end
    end

    context 'when the block gets calls the controller method' do
      let(:block) { proc { match? } }

      context 'when the method returns true' do
        let(:rails_controller_class) do
          Class.new(ActionController::Base) do
            def match?
              true
            end
          end
        end

        it do
          expect(subject.check?(controller)).to be_truthy
        end
      end

      context 'when the method returns false' do
        let(:rails_controller_class) do
          Class.new(ActionController::Base) do
            def match?
              false
            end
          end
        end

        it do
          expect(subject.check?(controller)).to be_falsey
        end
      end
    end

    context "when the block references a value defined outside" do
      let(:block) { val = value; proc { val } }
      let(:value) { [false, true].sample }

      it do
        expect(subject.check?(controller)).to eq(value)
      end
    end
  end
end
