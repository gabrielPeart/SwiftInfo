Pod::Spec.new do |s|
  s.name = 'SwiftInfo'
  s.module_name = 'SwiftInfo'
  s.version = '0.1.7'
  s.license = { type: 'GNU GPL v3.0', file: 'LICENSE.md' }
  s.summary = 'Extract and analyze the evolution of an iOS app\'s code.'
  s.source =  { :git => "https://github.com/gabrielPeart/SwiftInfo", :tag => s.version }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Sources/SwiftInfo/*.swift', 'Sources/SwiftInfoCore/*.swift', 'Sources/SwiftInfoCore/SourceKitWrapper/*.swift', 'Sources/SwiftInfoCore/Providers/*.swift', 'Sources/Csourcekitd/*.c', 'Sources/Csourcekitd/nclude/*.{h,modulemap}'
  s.homepage = 'https://github.com/rockbruno/SwiftInfo'
  s.authors = { 'Bruno Rocha' => 'brunorochaesilva@gmail.com' }
  s.preserve_paths = '*'
  s.exclude_files = '**/file.zip'
end
