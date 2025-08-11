# Uncomment the next line to define a global platform for your project
# platform :ios, '15.6'

def globalPods
  pod 'RxSwift', '~> 6.1.0'
  pod 'libPhoneNumber-iOS', '~> 0.9.15'
  pod 'Log'
end

def globalTestPods
  pod 'RxBlocking', '~> 6.1.0'
  pod 'RxTest', '~> 6.1.0'
end

def swinjectPod
  pod 'Swinject', '~> 2.7.1'
end

def networkPod
  pod 'Alamofire', '~> 5.4.4'
  pod 'RxAlamofire', '~> 6.1.1'
end

target 'CoinRankingCrypto' do
  use_frameworks!

  # Pods for CoinRankingCrypto
  globalPods
  swinjectPod
  pod 'lottie-ios'
  pod 'RxGesture', '~> 4.0.0'
  pod 'RxDataSources', '~> 5.0.0'
  pod 'Kingfisher', '~> 7.8.1'
  pod 'KingfisherSVG', '~> 1.0.0'
  pod 'Wormholy', :configurations => ['Debug', 'Release']
  pod 'MaterialComponents/TextControls'

  target 'CoinRankingCryptoTests' do
    inherit! :search_paths
    # Pods for testing
  globalTestPods
  end
  
end

target 'CoinRankingCryptoData' do
  use_frameworks!

  # Pods for CoinRankingCryptoData
  globalPods
  swinjectPod
  networkPod
  pod 'RealmSwift', '~> 10.7.0'
  target 'CoinRankingCryptoDataTests' do
    # Pods for testing
  globalTestPods
  end
  
end

target 'CoinRankingCryptoDependencyInjection' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CoinRankingCryptoDependencyInjection
  swinjectPod

end

target 'CoinRankingCryptoDomain' do
  use_frameworks!

  # Pods for CoinRankingCryptoDomain
  globalPods

  target 'CoinRankingCryptoDomainTests' do
    # Pods for testing
  globalTestPods
  end

end

deployment_target = '15.6'

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
            end
        end
        project.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        end

    end
end
