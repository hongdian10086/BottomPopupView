Pod::Spec.new do |s|
s.name         = 'bottomPopupView'
s.version      = '0.0.4'
s.summary      = '自定义Picker底部弹框'
s.homepage     = 'https://github.com/hongdian10086/BottomPopupView'
s.license      = 'MIT'
s.authors      = {'guodaxia' => 'guoqihai@126.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/hongdian10086/BottomPopupView.git', :tag => s.version}
s.source_files = 'BottomPopupView/PickerView/**/*'
s.requires_arc = true
end