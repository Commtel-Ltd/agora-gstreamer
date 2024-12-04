plugin_c_args = ['-DHAVE_CONFIG_H', '-DBOOB']  # Corrected the c_args syntax

cdata = configuration_data()
cdata.set_quoted('PACKAGE_VERSION', gst_version)
cdata.set_quoted('PACKAGE', 'gst-agora')
cdata.set_quoted('GST_LICENSE', 'LGPL')
cdata.set_quoted('GST_API_VERSION', api_version)
cdata.set_quoted('GST_PACKAGE_NAME', 'agora source and sink plugin')
cdata.set_quoted('GST_PACKAGE_ORIGIN', 'https://www.agora.io')
configure_file(output : 'config.h', configuration : cdata)

# Dependencies
gst_dep = dependency('gstreamer-1.0')
gst_base_dep = dependency('gstreamer-base-1.0')
gst_app_dep = dependency('gstreamer-app-1.0')
gobject_dep = dependency('gobject-2.0')
glib_dep = dependency('glib-2.0')
x264_dep = dependency('x264')
swscale_dep = dependency('libswscale')
opus_dep = dependency('opus')
avcodec_dep = dependency('libavcodec')

# Find libgstagorac and libagora_rtc_sdk
cc = meson.get_compiler('c')
libgstagorac_dep = cc.find_library('gstagorac', dirs: ['/usr/local/lib'], required: true)
libagora_rtc_sdk_dep = cc.find_library('agora_rtc_sdk', dirs: ['/usr/local/lib'], required: true)

# Build the agoraioudp plugin
agoraioudp_sources = [
  'agoraioudp/gstagoraioudp.c',
]

gstagorioudp = shared_library(
  'gstagoraioudp',
  agoraioudp_sources,
  c_args: plugin_c_args,
  dependencies : [
    gst_dep,
    gst_base_dep,
    gst_app_dep,
    gobject_dep,
    glib_dep,
    x264_dep,
    swscale_dep,
    opus_dep,
    avcodec_dep,
    libgstagorac_dep,
    libagora_rtc_sdk_dep,
  ],
  install : true,
  install_dir : plugins_install_dir,
)
