Pod::Spec.new do |s|

    s.name         = 'CLPhotoWall'
    s.version      = '1.0.1'
    s.summary      = 'An easy way to select photos from systemPhotoAsset.'
    s.homepage     = 'https://github.com/qcl901028/CLPhotoWall'
    s.license      = 'MIT'
    s.authors      = {'秦传龙' => 'qcl901028@gmail.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/qcl901028/CLPhotoWall.git', :tag => s.version}
    s.source_files = 'PhotoKit/CLPhotoWall/**/*.{h,m,png}'
    s.requires_arc = true

end
