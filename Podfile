platform :ios, '15.0'
use_frameworks!
inhibit_all_warnings!

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
end

target 'PhotoGallery' do
  
  #UI
  pod 'SnapKit'
  pod 'Kingfisher'
  
  #Networking
  pod 'Moya'
  
  #Loggers
  pod 'CocoaLumberjack/Swift'
  
end
