# Load the Module::Install bundled in ./inc/
use inc::Module::Install;

# Define metadata
name           'Class-Method-Modifiers';
all_from       'lib/Class/Method/Modifiers.pm';
githubmeta;

test_requires 'Test::Fatal';
test_requires 'Test::More';
test_requires 'Test::Requires';

author_requires 'Class::MOP';

WriteAll;

