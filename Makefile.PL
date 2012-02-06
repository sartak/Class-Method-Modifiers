# Load the Module::Install bundled in ./inc/
use inc::Module::Install;

# Define metadata
name           'Class-Method-Modifiers';
all_from       'lib/Class/Method/Modifiers.pm';
githubmeta;

requires 'Sub::Name';
test_requires 'Test::Fatal';
test_requires 'Test::More';
test_requires 'Class::MOP';

WriteAll;

