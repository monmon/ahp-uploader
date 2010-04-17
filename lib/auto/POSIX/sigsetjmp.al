# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 395 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/sigsetjmp.al)"
sub sigsetjmp {
    unimpl "sigsetjmp() is C-specific: use eval {} instead";
}

# end of POSIX::sigsetjmp
1;
