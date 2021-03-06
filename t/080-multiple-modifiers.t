#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 2;

my @seen;

my @expected = qw/ before
                   around-before
                       orig
                   around-after
                   after         /;

my $child = Child->new();
$child->orig();
is_deeply(\@seen, \@expected, "multiple modifiers in one class");

@seen = ();
@expected = qw/ beforer around-beforer
                before  around-before
                orig
                around-after after
                around-afterer afterer /;

my $childer = Childer->new();
$childer->orig();
is_deeply(\@seen, \@expected, "multiple modifiers subclassed with multiple modifiers");

BEGIN
{
    package Parent;
    sub new { bless {}, shift }
    sub orig
    {
        push @seen, 'orig';
    }
}

BEGIN
{
    package Child;
    our @ISA = 'Parent';
    use Class::Method::Modifiers;

    after 'orig' => sub
    {
        push @seen, 'after';
    };

    around 'orig' => sub
    {
        my $orig = shift;
        push @seen, 'around-before';
        $orig->();
        push @seen, 'around-after';
    };

    before 'orig' => sub
    {
        push @seen, 'before';
    };
}

BEGIN
{
    package Childer;
    our @ISA = 'Child';
    use Class::Method::Modifiers;

    after 'orig' => sub
    {
        push @seen, 'afterer';
    };

    around 'orig' => sub
    {
        my $orig = shift;
        push @seen, 'around-beforer';
        $orig->();
        push @seen, 'around-afterer';
    };

    before 'orig' => sub
    {
        push @seen, 'beforer';
    };
}
