Pod::Spec.new do |s|
  s.name = 'SwiftInfo'
  s.module_name = 'SwiftInfo'
  s.version = '0.1.1'
  s.license = { type: 'GNU GPL v3.0', file: 'LICENSE.md' }
  s.summary = 'Extract and analyze the evolution of an iOS app\'s code.'
  s.source = { http: "https://github.com/gabrielPeart/SwiftInfo/archive/#{s.version}.zip" }
  s.homepage = 'https://github.com/rockbruno/SwiftInfo'
  s.authors = { 'Bruno Rocha' => 'brunorochaesilva@gmail.com' }
  s.preserve_paths = '*'
  s.exclude_files = '**/file.zip'
end
