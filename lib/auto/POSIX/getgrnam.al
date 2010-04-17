# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 328 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/getgrnam.al)"
sub getgrnam {
    usage "getgrnam(name)" if @_ != 1;
    CORE::getgrnam($_[0]);
}

# end of POSIX::getgrnam
1;
