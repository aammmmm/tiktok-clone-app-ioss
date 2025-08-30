platform :ios, '16.0'
use_frameworks!

workspace 'TikTokCloneiOSs.xcworkspace'

def common_pods
  pod 'Moya'
  pod 'Kingfisher'
end

target 'TikTokCloneApp' do
  project 'TikTokCloneApp/TikTokCloneApp.xcodeproj'
  common_pods
  pod 'netfox'
end

target 'Feed' do
  project 'Feed/Feed.xcodeproj'
  common_pods
  pod 'netfox'
end

target 'Player' do
  project 'Player/Player.xcodeproj'
  common_pods
  pod 'netfox'
end

target 'Core' do
  project 'Core/Core.xcodeproj'
  pod 'Moya'
end
