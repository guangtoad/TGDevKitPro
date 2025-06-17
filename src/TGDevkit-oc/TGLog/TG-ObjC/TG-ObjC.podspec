Pod::Spec.new do |s|
  s.name             = 'TG-ObjC'
  s.version          = '0.1.2'
  s.summary          = 'TG-ObjC.'

  s.description      = 'description of TG-ObjC.'

  s.homepage         = 'https://gitee.com/guangtoad'
  # s.screenshots     = ''
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'guang_toad' => 'guang_toad@outlook.com' }

  s.source           = { :git => 'https://gitee.com/guangtoad/TG-ObjC.git', :tag => s.version }
  # s.social_media_url = ''

  s.ios.deployment_target = '9.0'

  s.public_header_files = 'TG-ObjC/TG-ObjC/**/*.h'
  s.source_files = ['TG-ObjC/TG-ObjC/**/*']
  # s.source_files = ['TG-ObjC/TG-ObjC/**/*','TG-ObjC/TGFoundation/**/*','TG-ObjC/TGKit/**/*']
  
  # s.resource_bundles = {
  #   'TG-ObjC' => ['TG-ObjC/Assets/*.png']
  # }

  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.subspec 'TGFoundation' do |tgf|
    tgf.ios.deployment_target = '9.0'
    tgf.source_files = 'TG-ObjC/TGFoundation/**/*'
    tgf.public_header_files = 'TG-ObjC/TGFoundation/**/*.h'
    # tgf.dependency 'TG_Foundation'
  end

  s.subspec 'TGKit' do |tgk|
    tgk.ios.deployment_target = '9.0'
    tgk.source_files = 'TG-ObjC/TGKit/**/*'
    tgk.public_header_files = 'TG-ObjC/TGKit/**/*.h'
    tgk.dependency 'TG-ObjC/TGFoundation'
  end
  s.subspec 'TGUtility' do |tgu|
    tgu.ios.deployment_target = '9.0'
    tgu.source_files = 'TG-ObjC/TGUtility/**/*'
    tgu.public_header_files = 'TG-ObjC/TGUtility/**/*.h'
    tgu.dependency 'TG-ObjC/TGKit'
  end
  
end
