#
# Be sure to run `pod lib lint SSUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SSUtils'
  s.version          = '0.1.0'
  s.summary          = '工具类集合：包含普通方法、静态方法、类别'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
一些小功能的工具类集合
                       DESC

  s.homepage         = 'https://github.com/sususu/SSUtils'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sujiang' => 'sujiang@infzm.com' }
  s.source           = { :git => 'https://github.com/sususu/SSUtils.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/sunima0318'

  s.ios.deployment_target = '7.0'

  s.source_files = 'SSUtils/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SSUtils' => ['SSUtils/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
