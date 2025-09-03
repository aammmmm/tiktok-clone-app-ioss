platform :ios, '16.0'
use_frameworks!

workspace 'TikTokCloneiOSs.xcworkspace'

def common_pods
  pod 'Moya'
  pod 'Kingfisher'
end

target 'TikTokCloneApp' do
  project 'TikTokCloneApp/TikTokCloneApp.xcodeproj'
  pod 'netfox'
  common_pods
end

target 'Feed' do
  project 'Feed/Feed.xcodeproj'
  common_pods
end

target 'Player' do
  project 'Player/Player.xcodeproj'
  common_pods
end

target 'Post' do
  project 'Post/Post.xcodeproj'
  common_pods
end

target 'Core' do
  project 'Core/Core.xcodeproj'
  common_pods
end

target 'DataService' do
  project 'DataService/DataService.xcodeproj'
  common_pods
end

target 'Worker' do
  project 'Worker/Worker.xcodeproj'
  common_pods
end
