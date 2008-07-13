use inc::Module::Install;

all_from       'lib/Class/Method/Modifiers.pm';

build_requires 'Test::More';
build_requires 'Test::Exception';

WriteAll;

