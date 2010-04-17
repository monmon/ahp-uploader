# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 774 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/wait.al)"
sub wait {
    usage "wait()" if @_ != 0;
    CORE::wait();
}

# end of POSIX::wait
1;
