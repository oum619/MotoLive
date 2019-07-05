# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'MotoLive' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MotoLive
  pod 'SDWebImage', '~> 5.0.2'
  pod 'RealmSwift', '~> 3.16.0'
  target 'MotoLiveTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.2'
    end
  end
end

