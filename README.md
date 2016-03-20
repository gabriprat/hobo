[ ![Codeship Status for Hobo/hobo](https://codeship.com/projects/6dd714c0-6cd7-0132-7429-3a463caf9dbd/status?branch=master)](https://codeship.com/projects/54101)

The README for hobo is in hobo/README.md

However, if youre reading this, you'll probably be more interested in 
hobo/CHANGES-2.1.md or [Hobo Central](http://cookbook.hobocentral.net)

### Unit tests

    export HOBODEV=`pwd`
    for f in dryml hobo_support hobo_fields hobo ; do cd $f ; bundle install ; cd .. ; done
    rake test
    unset HOBODEV

### Integration tests

See integration\_tests/agility\_bootstrap/README.md for details

### Smoke test

This test is not super important. It's important that this test be run
just before gems are released, but we won't see much benefit if people
other than the maintainer run this test.

Prerequisites:  RVM, wget.   Creates and uses the hobo-smoke rvm gemset.

    unset HOBODEV
    export HOBODEV
    cd integration_tests
    ./smoke_test.sh

