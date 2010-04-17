# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 657 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/system.al)"
sub system {
    usage "system(command)" if @_ != 1;
    CORE::system($_[0]);
}

# end of POSIX::system
1;
