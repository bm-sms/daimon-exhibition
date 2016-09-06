# Original code is came from https://robots.thoughtbot.com/automatically-wait-for-ajax-with-capybara

module WaitForAjax
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      sleep 0.1 until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    evaluate_script('jQuery.active').zero?
  end
end

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end
