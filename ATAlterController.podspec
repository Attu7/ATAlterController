#
#  Be sure to run `pod spec lint ATAlterController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

 
   # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "ATAlterController"
  s.version      = "1.0.0"
  s.summary      = "A custom alterController." 
  s.description  = <<-DESC
                      A custom alterController
                   DESC
  s.homepage         = "https://github.com/Attu7/ATAlterController"  
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }    
  s.author           = { "Attu7" => "953224204@qq.com" }  
  s.source           = { :git => "https://github.com/Attu7/ATAlterController.git", :tag => "1.0.0" }  
  #s.source_files     = 'ATAlterController/*'
  # s.social_media_url = 'https://twitter.com/NAME'  
  
  s.platform     = :ios, '7.0'  
  # s.ios.deployment_target = '5.0'  
  # s.osx.deployment_target = '10.7'  
  s.requires_arc = true  
  
  s.subspec 'ATAlterController' do |ss|
    ss.source_files  = 'ATAlterController/*'
  end  
  

end
