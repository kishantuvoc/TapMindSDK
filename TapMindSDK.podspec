Pod::Spec.new do |s|
  s.name             = 'TapMindSDK'
  s.version          = '1.0.0'
  s.summary          = 'A high-performance iOS SDK for delivering intelligent and optimized ads.'

  s.description      = <<-DESC
  TapMindSDK is a lightweight and scalable iOS advertising SDK designed to deliver high-quality, optimized advertisements. It helps developers monetize their applications efficiently while maintaining a smooth and engaging user experience.
  DESC

  s.homepage         = 'https://github.com/kishantuvoc/TapMindSDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kishan Italiya' => 'kishan.italiya@tovoc.com' }

  s.platform         = :ios, '13.0'
  s.swift_version    = '5.0'

  s.source           = {
    :git => 'https://github.com/kishantuvoc/TapMindSDK.git',
    :tag => s.version.to_s
  }
s.vendored_frameworks = 'TapMindSDK.xcframework'
  #s.source_files     = 'TapMindSDK/**/*.{h,m}'
  #s.public_header_files = 'TapMindSDK/Public/**/*.h'
  #s.exclude_files    = 'TapMindSDK/Exclude'
#s.static_framework = true
s.requires_arc = true
# 👉 Dependencies
  s.dependency 'Google-Mobile-Ads-SDK'
  s.dependency 'GoogleUserMessagingPlatform'
end
