# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 399 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/kill.al)"
sub kill {
    usage "kill(pid, sig)" if @_ != 2;
    CORE::kill $_[1], $_[0];
}

# end of POSIX::kill
1;
