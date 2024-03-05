RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end
end
Capybara.add_selector(:test_id) do
  css { |val| %([data-test-id="#{val}"]) }
end
