Pod::Spec.new do |s|
  s.name         = "BrewDogCore"
  s.version      = "0.0.1"
  s.summary      = "BrewDog logic"
  s.homepage     = "http:www.google.com"
  s.license      = "MIT"
  s.author       = { "Pia Muñoz" => "piamunozt@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios, "9.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :path => "." }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "**/*.{swift,m,h}"

  # ――― Dependencies ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.dependency "BSWFoundation"
  s.dependency "RealmSwift"

	# ――― Bundle ------―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
	s.resource_bundles = {
    'BrewDogCoreBundle' => [
        'Fake/**/*.{xib,json}'
    ]
  }

end
