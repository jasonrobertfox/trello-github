group :tests do
  # Run code quality checks against all source
  guard :rubocop, all_on_start: false do
    watch(%r{^spec/.+\.rb$})
    watch(%r{^lib/.+\.rb$})
    watch(%r{^.+\.(rb|ru)$})
    watch 'Gemfile'
    watch 'Rakefile'
  end

  group :unit do
    guard :rspec, failed_mode: :none do
      watch(%r{^spec/unit/.+_spec\.rb$})
      watch(%r{^lib/(.+)\.rb$})     { |m| "spec/unit/lib/#{m[1]}_spec.rb" }
      watch('spec/spec_helper.rb')
    end
  end

  group :integration do
    guard :rspec do
      watch(%r{^spec/integration/.+_spec\.rb$})
      watch(%r{^lib/(.+)\.rb$})     { |m| "spec/integration/lib/#{m[1]}_spec.rb" }
      watch('spec/spec_helper.rb')
    end
  end
end
