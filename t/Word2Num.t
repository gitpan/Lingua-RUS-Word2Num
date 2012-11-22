#!/usr/bin/env perl
# For Emacs: -*- mode:cperl; mode:folding; coding:utf-8 -*-
#
# Copyright (C) PetaMem, s.r.o. 2009-present
#

# {{{ use block

use strict;
use warnings;
use 5.10.1;

use utf8;

use lib $ENV{PMLIB_INC};

use Test::More;

use PMLIB::Test          qw(:ALL);

# }}}

# {{{ basic tests

my $DISABLE = 0;
my $module;
my $tests;

BEGIN {
    ($module, $tests) = basic_prolog('Lingua::RUS::Word2Num');
}

use Lingua::RUS::Word2Num          qw(w2n);

# }}}

# {{{ w2n

$tests += t_w2n($DISABLE);
sub t_w2n {
    return 0 if (shift());
    my @wn = func_prolog('w2n');
    my $tests = 1;

    push @wn, [
        [
            'ноль',
            [0],
            '0 in Russia',
        ],
        [
            'восемь',
            [8],
            '8 in Russian'
        ],
        [
            'пятьдесят',
            [50],
            '50 in Russian',
        ],
        [
            'сто тридцать три',
            [133],
            '133 in Russian',
        ],
        [
            'девятьсот девяносто девять',
            [999],
            '999 in Russian'
        ],
        [
            'nonexisting',
            [undef],
            'nonexisting char -> undef'
        ],
        [
            undef,
            [],
            'undef args'
        ],
    ];

    $tests += function_pmtloop(@wn);

    return $tests;
}

# }}}

done_testing($tests);

__END__
