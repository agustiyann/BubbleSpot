Pod::Spec.new do |s|
  s.name             = 'BubbleSpot'
  s.version          = '0.1.0'
  s.summary          = 'BubbleSpot is a lightweight and customizable tooltip library designed for Swift iOS developers.'

  s.homepage         = 'https://github.com/agustiyann/BubbleSpot'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'agustiyan' => 'agustiyaninfo@gmail.com' }
  s.source           = { :git => 'https://github.com/agustiyann/BubbleSpot.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'

  s.source_files = 'Sources/BubbleSpot/**/*'
end
