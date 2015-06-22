
Pod::Spec.new do |s|
  s.name             = "YVSlideOutAnimation"
  s.version          = "0.1.0"
  s.summary          = "Simple library for UIView slide out effect."
  s.description      = <<-DESC
                       Simple UIView category for adding slide out animation. Inspired by animations used here: https://github.com/MartinRGB/GiftCard-iOS

                       DESC
  s.homepage         = "https://github.com/canep1990/YVSlideOutAnimation"
  s.license          = 'MIT'
  s.author           = { "Yury Voskresensky" => "canep1990@mail.ru" }
  s.source           = { :git => "https://github.com/canep1990/YVSlideOutAnimation.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'YVSlideOutAnimation' => ['Pod/Assets/*.png']
  }

end

