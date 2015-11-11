Pod::Spec.new do |s|
  s.name		= 'TBAVersionTracker'
  s.version		= '1.0.0'
  s.summary		= 'Version and build tracker'
  s.homepage	= 'http://www.thebinaryarchitect.com'
  s.license		= 'MIT'
  s.author		= { 'tba' => 'thebinaryarchitect@gmail.com'}
  s.source		= { :git => 'https://thebinaryarchitect@bitbucket.org/thebinaryarchitect/chocolate.git', :branch => 'master' }

  s.platform		= :ios, '8.0'
  s.requires_arc	= true
  
  s.source_files	= 'TBAVersionTracker/*.{h,m}'

  s.module_name		= 'TBAVersionTracker'
end