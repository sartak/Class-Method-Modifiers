use strict;
use warnings;

use Test::More;
use Test::Requires 'Class::MOP';

# code for this sub is taken directly from
# Test::CleanNamespaces::build_namespaces_clean
sub imports
{
    my $ns = shift;
    my $meta = Class::MOP::class_of($ns) || Class::MOP::Class->initialize($ns);
    my %methods = map { ($_ => 1) } $meta->get_method_list;
    my @symbols = keys %{ $meta->get_all_package_symbols('CODE') || {} };
    my @imports = grep { !$methods{$_} } @symbols;
}

{
    package Foo;
    sub foo { print "normal Foo::foo sub\n"; }
    sub bar { print "normal Foo::bar sub\n"; }
    sub baz { print "normal Foo::baz sub\n"; }
}

ok(
    !(grep { $_ eq 'foo' || $_ eq 'bar' || $_ eq 'baz' } imports('Foo')),
    "original subs are not in Foo's list of imports",
)
    or note('Foo has imports: ' . join(', ', imports('Foo')));

# this should also pass:
# namespaces_clean('Foo');

eval {
    package Foo;
    use Class::Method::Modifiers;
    Test::More::note 'redefining Foo::foo';

    around foo => sub {
        my $orig = shift;
        my $ret = $orig->(@_);
        print "wrapped foo sub\n"
    };
    around bar => sub { print "wrapped bar sub\n" };
    around baz => sub { print "wrapped baz sub\n" };
};

ok(
    !(grep { $_ eq 'foo' || $_ eq 'bar' || $_ eq 'baz' } imports('Foo')),
    "modified subs are not in Foo's list of imports",
)
    or note('Foo has imports: ' . join(', ', imports('Foo')));

# this should also still pass, except for the 'before', 'around' and 'after'
# subs that CMM itself imported which should be cleaned:
# namespaces_clean('Foo');

done_testing;
