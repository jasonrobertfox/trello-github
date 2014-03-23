shared_examples 'command_factory' do
  it 'should respond to build' do
    cf.should respond_to :build
  end

  it 'should be initialized with a list of verbs' do
    cf.verbs.should eq verbs
  end
end

shared_examples 'command' do
  it 'should respond to execute' do
    c.should respond_to :execute
  end
end
