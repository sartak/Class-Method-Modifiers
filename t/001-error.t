#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 4;
use Test::Exception;

do {
    package Class1;
    use Class::Method::Modifiers;

    ::throws_ok {
        before foo => sub {};
    } qr/The method 'foo' is not found in the inheritance hierarchy for class Class1/;
};

do {
    package Class2;
    use Class::Method::Modifiers;

    ::throws_ok {
        after foo => sub {};
    } qr/The method 'foo' is not found in the inheritance hierarchy for class Class2/;
};

do {
    package Class3;
    use Class::Method::Modifiers;

    ::throws_ok {
        around foo => sub {};
    } qr/The method 'foo' is not found in the inheritance hierarchy for class Class3/;
};

do {
    package Class4;
    use Class::Method::Modifiers;

    sub foo {}

    ::throws_ok {
        around 'foo', 'bar' => sub {};
    } qr/The method 'bar' is not found in the inheritance hierarchy for class Class4/;
};

