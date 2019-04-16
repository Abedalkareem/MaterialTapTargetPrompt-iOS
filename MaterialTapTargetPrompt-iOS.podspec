#
# Be sure to run `pod lib lint MaterialTapTargetPrompt-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MaterialTapTargetPrompt-iOS'
  s.version          = '1.0.4'
  s.summary          = 'A iOS version of Material Tap Target Prompt.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A iOS version of Material Tap Target Prompt ,Written in Swift and can be used in swift or objective c projects.
                       DESC

  s.homepage         = 'https://github.com/Abedalkareem/MaterialTapTargetPrompt-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Abedalkareem' => 'abedalkareem.omreyh@yahoo.com' }
  s.source           = { :git => 'https://github.com/Abedalkareem/MaterialTapTargetPrompt-iOS.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/AbedalkareemOmr'
  s.swift_version = '5.0'

  s.ios.deployment_target = '9.0'

  s.source_files = 'MaterialTapTargetPrompt-iOS/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MaterialTapTargetPrompt-iOS' => ['MaterialTapTargetPrompt-iOS/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
