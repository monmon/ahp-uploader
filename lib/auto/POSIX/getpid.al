# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 888 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/getpid.al)"
sub getpid {
    usage "getpid()" if @_ != 0;
    $$;
}

# end of POSIX::getpid
1;
