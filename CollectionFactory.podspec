Pod::Spec.new do |s|
  s.name         = "CollectionFactory"
  s.version      = "1.3.0"
  s.summary      = "Translation between native collections in Objective-C and serialized formats like JSON."
  s.homepage     = "https://github.com/elliotchance/CollectionFactory"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Elliot Chance" => "elliotchance@gmail.com" }
  s.platform     = :ios, '5.0', :osx, '10.8'
  s.source       = { :git => "https://github.com/elliotchance/CollectionFactory.git", :tag => "v#{s.version}" }
  s.source_files = 'CollectionFactory/*.{h,m}'
  s.requires_arc = true
end
