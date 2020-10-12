Pod::Spec.new do |s|
  s.name     = "KJExtensionHandler"
  s.version  = "0.0.1"
  s.summary  = "77 ExtensionHandler"
  s.homepage = "https://github.com/yangKJ/KJExtensionHandler"
  s.license  = "MIT"
  s.license  = {:type => "MIT", :file => "LICENSE"}
  s.license  = "Copyright (c) 2020 yangkejun"
  s.author   = { "77" => "393103982@qq.com" }
  s.platform = :ios
  s.source   = {:git => "https://github.com/yangKJ/KJExtensionHandler.git",:tag => "#{s.version}"}
  s.social_media_url = 'https://www.jianshu.com/u/c84c00476ab6'
  s.requires_arc = true

  s.default_subspec  = 'Kit'
  s.ios.source_files = 'KJExtensionHandler/KJExtensionHeader.h'
  s.resources = "README.md"

  s.subspec 'Kit' do |y|
    y.source_files = "KJExtensionHandler/Kit/**/*.{h,m}"
    y.public_header_files = 'KJExtensionHandler/Kit/*.h',"KJExtensionHandler/Kit/**/*.h"
    y.frameworks = 'Foundation','UIKit','Accelerate'
  end

  s.subspec 'Foundation' do |fun|
    fun.source_files = "KJExtensionHandler/Foundation/**/*.{h,m}"
    fun.public_header_files = 'KJExtensionHandler/Foundation/*.h',"KJExtensionHandler/Foundation/**/*.h"
    fun.dependency 'KJExtensionHandler/Kit'
  end
  
  s.subspec 'Exception' do |ex|
    ex.source_files = "KJExtensionHandler/Exception/**/*.{h,m}"
    ex.public_header_files = 'KJExtensionHandler/Exception/*.h',"KJExtensionHandler/Exception/**/*.h"
    ex.dependency 'KJExtensionHandler/Kit'
  end
  
end


