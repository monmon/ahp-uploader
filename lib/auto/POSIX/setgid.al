# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 922 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/setgid.al)"
sub setgid {
    usage "setgid(gid)" if @_ != 1;
    $( = $_[0];
}

# end of POSIX::setgid
1;
