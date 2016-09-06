RSpec::Matchers.define :have_header do |expected|
  match do |actual|
    actual.has_css?('h1', text: expected)
  end

  failure_message do |actual|
    if actual.has_css?('h1')
      "expected that page has header #{expected.inspect}, but actual #{actual.find('h1').text.inspect}."
    else
      'expected that page has header. Can you confirm your page has `.h1`?'
    end
  end
end

RSpec::Matchers.define :have_notice do |expected|
  match do |actual|
    actual.has_css?('.notice', text: expected)
  end

  failure_message do |actual|
    if actual.has_css?('.notice')
      "expected that page has notice #{expected.inspect}, but actual #{actual.find('.notice').text.inspect}."
    else
      'expected that page has notice. Can you confirm your page has `.notice`?'
    end
  end
end
