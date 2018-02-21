#
# Be sure to run `pod lib lint PhotoViewControllerSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PhotoViewControllerSwift'
  s.version          = '0.1.0'
  s.summary          = 'PhotoViewControllerSwift is a controller to display a photo, in Swift !'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is a very small viewController to display images, in swift, allowing to zoom on it. It was mainly done in order to first try pod building and publishing. Not very usefull I think, but who really knows :) ?
                       DESC

  s.homepage         = 'https://github.com/nicoduj/PhotoViewControllerSwift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nicoduj' => 'nicolas.dujardin@gmail.com' }
  s.source           = { :git => 'https://github.com/nicoduj/PhotoViewControllerSwift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dujnic'

  s.ios.deployment_target = '9.0'

  s.source_files = 'PhotoViewControllerSwift/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PhotoViewControllerSwift' => ['PhotoViewControllerSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
