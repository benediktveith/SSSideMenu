Pod::Spec.new do |s|


  s.name         = "SSSideMenu"
  s.version      = "0.2.0"
  s.summary      = "A Slide-Out Side Menu."

  s.description  = <<-DESC
                   * Side Menu using an UITableViewController as menu.
				   * Easy to open / close side menu via Button Action
				   * Drag to open / close side menu
				   * Animated
				   * No need of NIB`s etc.
				   DESC

  s.homepage     = "https://github.com/scherersoftware/SSSideMenu"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Benedikt Veith"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/scherersoftware/SSSideMenu.git", :tag => "0.2.0" }
  s.source_files  = "Classes", "SSSideMenu/*.{h,m}"
end 