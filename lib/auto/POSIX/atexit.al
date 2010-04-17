# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 587 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/atexit.al)"
sub atexit {
    unimpl "atexit() is C-specific: use END {} instead";
}

# end of POSIX::atexit
1;
