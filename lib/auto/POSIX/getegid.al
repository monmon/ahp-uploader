# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 857 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/getegid.al)"
sub getegid {
    usage "getegid()" if @_ != 0;
    $) + 0;
}

# end of POSIX::getegid
1;
