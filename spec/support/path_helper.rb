def spec_path
  File.expand_path('..', File.dirname(__FILE__))
end

def base_fixture_path
  File.join(spec_path, 'fixtures')
end

def base_presenter_path
  File.join(base_fixture_path, 'presenters')
end

def base_expectation_path
  File.join(spec_path, 'expectations')
end

def fixture_path(fixture = nil)
  return base_fixture_path unless fixture
  fixture.gsub!(/\.entity$/, '')
  File.join(base_fixture_path, "#{fixture}.entity")
end

def expectation_path(expectation = nil, format = nil)
  return base_expectation_path unless expectation
  expectation, format_from_expectation = expectation.split('.')
  format ||= format_from_expectation
  File.join(base_expectation_path, "#{expectation}.#{format}")
end
