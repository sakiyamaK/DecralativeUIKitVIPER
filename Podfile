platform :ios, '13.0'
inhibit_all_warnings!

target 'DecralativeUIKitVIPER' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DecralativeUIKitVIPER

  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxOptional'
  pod 'RxKeyboard'
  pod 'NSObject+Rx'
  pod 'Moya/RxSwift'
  pod 'Alamofire'
  pod 'Action'
  pod 'IQKeyboardManagerSwift'  
  pod 'SnapKit'
  pod 'Kingfisher'
  pod 'KingfisherWebP'
  pod 'SwiftyAttributes'
  pod 'DeclarativeUIKit', :git => 'https://github.com/sakiyamaK/DeclarativeUIKit', :tag => '1.0.0'
  pod 'RxViewController'
  pod 'SwiftGen', '~> 6.0'
  
  # for test
  # pod 'Nimble', '~> 9.2'
  # pod 'Quick', '~> 4.0'


  # target 'DecralativeUIKitVIPERTests' do
  #   inherit! :search_paths
  #   # Pods for testing
  # end

  # target 'DecralativeUIKitVIPERUITests' do
  #   # Pods for testing
  # end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
