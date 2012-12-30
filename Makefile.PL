# Load the Module::Install bundled in ./inc/
use inc::Module::Install;
use Module::Install::AuthorRequires;
use Module::Install::ReadmeFromPod;
use Module::Install::GithubMeta;
use Module::Install::AutoLicense;

# Define metadata
name           'Class-Method-Modifiers';
all_from       'lib/Class/Method/Modifiers.pm';
readme_from    'lib/Class/Method/Modifiers.pm';
auto_license;
githubmeta;

perl_version '5.008';

test_requires 'Test::Fatal';
test_requires 'Test::More';

author_requires 'Class::MOP';

WriteAll;

