# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 268 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/assert.al)"
sub assert {
    usage "assert(expr)" if @_ != 1;
    if (!$_[0]) {
	croak "Assertion failed";
    }
}

# end of POSIX::assert
1;
