Pod::Spec.new do |s|
  s.name     = 'YYSlideGallery'
  s.version  = '0.0.1'
  s.author   = { 'ryan' => 'czwen1993@gmail.com' }
  s.homepage = 'https://github.com/czwen1993/YYSlideGallery'
  s.summary  = 'a gallery'
  s.license  = 'MIT'
  s.source   = { :git => 'https://github.com/czwen1993/YYSlideGallery.git', :tag => s.version.to_s }
  s.source_files = 'YYSlideGallery/YYSlideGallery/Classes/*.{h,m}'
  s.platform = :ios
  s.ios.deployment_target = '6.0'
  s.requires_arc = true
end