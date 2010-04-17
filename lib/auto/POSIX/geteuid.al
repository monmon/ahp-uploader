# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 862 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/geteuid.al)"
sub geteuid {
    usage "geteuid()" if @_ != 0;
    $> + 0;
}

# end of POSIX::geteuid
1;
