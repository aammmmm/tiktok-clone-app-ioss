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
  # Menambahkan pod Netfox untuk debugging jaringan di aplikasi utama
  pod 'netfox'
end

# Feed Module
target 'Feed' do
  project 'Feed/Feed.xcodeproj'
  common_pods
  # Menambahkan pod Netfox di modul Feed untuk debugging
  pod 'netfox'
end

# Player Module
target 'Player' do
  project 'Player/Player.xcodeproj'
  common_pods
  # Menambahkan pod Netfox di modul Player untuk debugging
  pod 'netfox'
end

# Core Module (shared code, biasanya juga butuh Moya misalnya)
target 'Core' do
  project 'Core/Core.xcodeproj'
  pod 'Moya'
end
