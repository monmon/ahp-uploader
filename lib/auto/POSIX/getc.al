# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 497 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/getc.al)"
sub getc {
    usage "getc(handle)" if @_ != 1;
    CORE::getc($_[0]);
}

# end of POSIX::getc
1;
