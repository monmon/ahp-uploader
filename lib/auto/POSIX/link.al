# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 908 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/link.al)"
sub link {
    usage "link(oldfilename, newfilename)" if @_ != 2;
    CORE::link($_[0], $_[1]);
}

# end of POSIX::link
1;