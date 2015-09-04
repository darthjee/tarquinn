shared_examples 'a method that adds a redirection rule' do |expected_class|
  it_behaves_like 'a method that adds a rule', :redirection, expected_class
end

shared_examples 'a method that adds a skip rule' do |expected_class|
  it_behaves_like 'a method that adds a rule', :skip, expected_class
end

shared_examples 'a method that adds a rule' do |rule, expected_class|
  let(:reverse_rule) { rule == :skip ? :redirection : :skip }
  it do
    expect do
      call_method
    end.to change { subject.public_send("#{rule}_blocks" ) }
  end

  it do
    call_method
    expect(subject.public_send("#{rule}_blocks" ).last).to be_a(expected_class)
  end

  it do
    expect do
      call_method
    end.not_to change { subject.public_send("#{reverse_rule}_blocks" ) }
  end
end

