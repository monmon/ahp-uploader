# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 946 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/utime.al)"
sub utime {
    usage "utime(filename, atime, mtime)" if @_ != 3;
    CORE::utime($_[1], $_[2], $_[0]);
}

E 1
1;
# end of POSIX::utime
