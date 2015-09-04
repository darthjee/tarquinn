shared_examples 'a method that adds a redirection rule' do |expected_class|
  it do
    expect do
      call_method
    end.to change { subject.redirection_blocks }
  end

  it do
    call_method
    expect(subject.redirection_blocks.last).to be_a(expected_class)
  end

  it do
    expect do
      call_method
    end.not_to change { subject.skip_blocks }
  end
end

shared_examples 'a method that adds a skip rule' do |expected_class|
  it do
    expect do
      call_method
    end.to change { subject.skip_blocks }
  end

  it do
    call_method
    expect(subject.skip_blocks.last).to be_a(expected_class)
  end

  it do
    expect do
      call_method
    end.not_to change { subject.redirection_blocks }
  end
end