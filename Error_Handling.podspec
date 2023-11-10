
Pod::Spec.new do |spec|
  spec.name         = "Error_Handling"
  spec.version      = "0.0.1"
  spec.summary      = "A CocoaPods library written in Swift."

  spec.description  = <<-DESC
This CocoaPods library helps you show custom error view.
                   DESC
  spec.homepage     = "https://github.com/Kamal-Negi/Error-Handling"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Kamal-Negi" => "kamal.negi@getmyparking.com" }
  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://github.com/Kamal-Negi/Error-Handling.git", :tag => "#{spec.version}" }

  spec.source_files  = "Error_Handling", "Error_Handling/**/*.{h,swift}"
  spec.exclude_files = "Classes/Exclude"

  spec.frameworks   = 'UIKit', 'Foundation'
  spec.swift_version = '5.0'

end
