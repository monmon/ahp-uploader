# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 789 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/localtime.al)"
sub localtime {
    usage "localtime(time)" if @_ != 1;
    CORE::localtime($_[0]);
}

# end of POSIX::localtime
1;
