# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'MindfulWaste' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Firebase/Core'
  pod 'SideMenuController'
  pod 'Charts/Realm'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'FoldingCell'
  pod 'KDCircularProgress'
  pod 'Material'
  pod 'expanding-collection'

  # Pods for MindfulWaste

  target 'MindfulWasteTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MindfulWasteUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
