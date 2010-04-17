# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 363 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/sin.al)"
sub sin {
    usage "sin(x)" if @_ != 1;
    CORE::sin($_[0]);
}

# end of POSIX::sin
1;
