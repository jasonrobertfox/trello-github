shared_examples 'command_factory' do

  it 'should respond to build' do
    mf.should respond_to :build
  end
end
