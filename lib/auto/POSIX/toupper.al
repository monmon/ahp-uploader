# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 280 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/toupper.al)"
sub toupper {
    usage "toupper(string)" if @_ != 1;
    uc($_[0]);
}

# end of POSIX::toupper
1;
