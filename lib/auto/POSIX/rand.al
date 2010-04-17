# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 645 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/rand.al)"
sub rand {
    unimpl "rand() is non-portable, use Perl's rand instead";
}

# end of POSIX::rand
1;
