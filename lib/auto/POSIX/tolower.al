# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 275 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/tolower.al)"
sub tolower {
    usage "tolower(string)" if @_ != 1;
    lc($_[0]);
}

# end of POSIX::tolower
1;
