use strict;
use inc::Module::Install 0.91;

name 'Log-Message-Structured';
all_from 'lib/Log/Message/Structured.pm';

requires 'Moose';
requires 'MooseX::Storage' => '0.26';
requires 'MooseX::Role::WithOverloading';
requires 'MooseX::Types::ISO8601';
requires 'MooseX::Role::Parameterized';
requires 'Moose::Autobox';
requires 'MooseX::Types';
requires 'MooseX::Types::Common';
requires 'DateTime';
requires 'Sys::Hostname';
requires 'JSON::Any';
requires 'namespace::autoclean';

test_requires 'Test::More' => '0.88';

WriteAll;

