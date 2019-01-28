# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'RealFitness' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ResumeARStarter

  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'
  pod 'SwiftyJSON'
  pod 'PKHUD',      '~> 5.0'
  pod 'IBMWatsonVisualRecognitionV3', '~> 1.3.1'

  # Pods for RealFitness
  pod 'FLAnimatedImage', '~> 1.0'
  pod 'LGPlusButtonsView', '~> 1.1.0'
  pod 'Firebase/Core'
  pod 'Firebase/Database'

  pod 'FNReactionsView'
  pod "UIImageView-Letters"

end

post_install do |installer|
  swift32Targets = ['SwiftCloudant', 'FNReactionsView']
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      new_xcconfig = xcconfig.sub('OTHER_LDFLAGS = $(inherited) -ObjC', 'OTHER_LDFLAGS = $(inherited)')
      File.open(xcconfig_path, "w") { |file| file << new_xcconfig }
      config.build_settings['SWIFT_VERSION'] = '4.2'
      if config.name == 'Debug'
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
        else
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
      end
    end
    if swift32Targets.include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.2'
      end
    end
  end
end
