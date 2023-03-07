#!/bin/bash

resolutions=(-1x-1 1920x1080 1280x720 854x480)
drivers=('MESA_GL_VERSION_OVERRIDE=2.1 MESA_GLSL_VERSION_OVERRIDE=210')
drivers+=('MESA_GL_VERSION_OVERRIDE=3.3 MESA_GLSL_VERSION_OVERRIDE=330 MESA_NO_DITHER=1')
drivers+=('__GLX_VENDOR_LIBRARY_NAME=mesa MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink  MESA_GL_VERSION_OVERRIDE=2.1 MESA_GLSL_VERSION_OVERRIDE=210')
drivers+=('__GLX_VENDOR_LIBRARY_NAME=mesa MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink  MESA_GL_VERSION_OVERRIDE=3.3 MESA_GLSL_VERSION_OVERRIDE=330')
drivers+=('__GLX_VENDOR_LIBRARY_NAME=mesa MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink  MESA_GL_VERSION_OVERRIDE=4.1 MESA_GLSL_VERSION_OVERRIDE=410')
drivers+=('__GLX_VENDOR_LIBRARY_NAME=mesa MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink  MESA_GL_VERSION_OVERRIDE=4.6 MESA_GLSL_VERSION_OVERRIDE=460')
driver_names=('V3D GL2.1' 'V3D GL3.3' 'Zink GL2.1' 'Zink GL3.3' 'Zink GL4.1' 'Zink GL4.6')

for dri_ind in {0..5}
do
    dri="${drivers[$dri_ind]}"
    dri_name="${driver_names[$dri_ind]}"
    for res in "${resolutions[@]}"
    do
        env $dri glmark2 -f test_config.txt --size $res | tee "result.$res.$dri_name.txt"
    done
done
