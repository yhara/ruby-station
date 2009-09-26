require 'celerity'

Before do
  # Manually control waiting for AJAX calls
  @browser = Celerity::IE.new
  
  # Wait for AJAX calls automatically
  # @browser = Celerity::Browser.new(:resynchronize => true)
end

After do
  @browser.close
end
