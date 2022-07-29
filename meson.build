
project('YAML_CPP', 'version', '0.7.0', 'languages', 'cpp', default_options : ['default_library=static'])
yaml-cpp-type = 'BOTH'
yaml-cpp-label-postfix = 'both'
build-shared = '$<BOOL:${YAML_BUILD_SHARED_LIBS}>'
contrib-pattern = 'src/contrib/*.cpp'
src-pattern = 'src/*.cpp'

yaml-cpp_lib = library('yaml-cpp', yaml-cpp-type, '')
yaml-cpp::yaml-cpp_lib = library('yaml-cpp::yaml-cpp', 'ALIAS', 'yaml-cpp')
subdir('test')
subdir('util')
