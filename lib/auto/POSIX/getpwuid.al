# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 378 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/getpwuid.al)"
sub getpwuid {
    usage "getpwuid(uid)" if @_ != 1;
    CORE::getpwuid($_[0]);
}

# end of POSIX::getpwuid
1;
