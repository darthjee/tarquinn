# frozen_string_literal: true

require 'spec_helper'

describe Tarquinn::Config do
  let(:subject) { described_class.new(:redirect) }

  describe '#add_redirection_rules' do
    context 'when not passing a block' do
      it_behaves_like 'a method that adds a redirection rule', Tarquinn::Condition::MethodCaller do
        let(:call_method) { subject.add_redirection_rules(:methods) }
      end
    end

    context 'when passing only a block' do
      it_behaves_like 'a method that adds a redirection rule', Tarquinn::Condition::ProcRunner do
        let(:call_method) { subject.add_redirection_rules { true } }
      end
    end
  end

  describe '#add_skip_rules' do
    context 'when not passing a block' do
      it_behaves_like 'a method that adds a skip rule', Tarquinn::Condition::MethodCaller do
        let(:call_method) { subject.add_skip_rules(:methods) }
      end
    end

    context 'when passing only a block' do
      it_behaves_like 'a method that adds a skip rule', Tarquinn::Condition::ProcRunner do
        let(:call_method) { subject.add_skip_rules { true } }
      end
    end
  end

  describe '#add_skip_action' do
    it_behaves_like 'a method that adds a skip rule', Tarquinn::Condition::ActionChecker do
      let(:call_method) { subject.add_skip_action(:methods) }
    end
  end
end
