# Load the Module::Install bundled in ./inc/
use inc::Module::Install;

# Define metadata
name           'Class-Method-Modifiers';
all_from       'lib/Class/Method/Modifiers.pm';
githubmeta;

build_requires 'Test::Fatal';

WriteAll;

