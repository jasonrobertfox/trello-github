# Encoding: utf-8

task default: :build_full

task build: [:clean, :prepare, :quality, :test]

desc 'Runs standard build activities.'
task build_full: [:build]

desc 'Runs quality checks.'
task quality: [:rubocop]

require 'rubocop/rake_task'
Rubocop::RakeTask.new

desc 'Removes the build directory.'
task :clean do
  FileUtils.rm_rf 'build'
end
desc 'Creates a basic build directory.'
task :prepare do
  FileUtils.mkdir_p('build/spec')
end

def get_rspec_flags(log_name, others = nil)
  "--format documentation --out build/spec/#{log_name}.log --format html --out build/spec/#{log_name}.html --format progress #{others}"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:test) do |t|
  ENV['COVERAGE'] = 'true'
  ENV['SYSTEM'] = 'false'
  t.pattern = FileList['spec/unit/**/*_spec.rb', 'spec/integration/**/*_spec.rb']
  t.rspec_opts = get_rspec_flags('unit_integration')
end
