#
#  Be sure to run `pod spec lint ABC.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "EncryptFMDB"
  s.version      = "0.0.1"
  s.summary      = "A short description of ABC."
  s.description  = "description"
  s.homepage     = "http://www.baidu.com"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author    = { "toad" => "guang_toad@outlook.com" }
  # s.platform     = :ios
  s.platform     = :ios, "12.0"
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => ".", :tag => "#{s.version}" }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.public_header_files = "Classes/**/*.h"

  s.xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_HAS_CODEC -DHAVE_USLEEP=1 -DSQLCIPHER_CRYPTO', 'HEADER_SEARCH_PATHS' => 'SQLCipher' }
  s.dependency 'FMDB'

end
