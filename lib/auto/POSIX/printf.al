# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 517 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/printf.al)"
sub printf {
    usage "printf(pattern, args...)" if @_ < 1;
    CORE::printf STDOUT @_;
}

# end of POSIX::printf
1;
