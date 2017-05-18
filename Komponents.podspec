Pod::Spec.new do |s|
    s.name             = "Komponents"
    s.version          = "0.2.0"
    s.summary          = "📦 React-inspired UIKit Components"
    s.homepage         = "https://github.com/freshOS/Komponents"
    s.license          = { :type => "MIT", :file => "LICENSE" }
    s.author           = "freshOS"
    s.platform         = :ios
    s.source           = { :git => "https://github.com/freshOS/Komponents.git", :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/sachadso'
    s.ios.deployment_target = "9.0"
    s.source_files = "Source/*.swift"
    s.description  = "Komponents is a Swift framework for building component-oriented interfaces.
Because it's unfair to need javascript to enjoy Components ! 😎"
end
