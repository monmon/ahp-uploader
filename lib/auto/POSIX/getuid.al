# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 898 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/getuid.al)"
sub getuid {
    usage "getuid()" if @_ != 0;
    $<;
}

# end of POSIX::getuid
1;
