platform :ios, '16.0'
use_frameworks!

workspace 'TikTokCloneiOSs.xcworkspace'

# Pod umum untuk semua modul
def common_pods
  pod 'Moya'
  pod 'Kingfisher'
end

# App Utama
target 'TikTokCloneApp' do
  project 'TikTokCloneApp/TikTokCloneApp.xcodeproj'
  common_pods
end

# Feed Module
target 'Feed' do
  project 'Feed/Feed.xcodeproj'
  common_pods
end

# Player Module
target 'Player' do
  project 'Player/Player.xcodeproj'
  common_pods
end

# Core Module (shared code, biasanya juga butuh Moya misalnya)
target 'Core' do
  project 'Core/Core.xcodeproj'
  pod 'Moya'
end
