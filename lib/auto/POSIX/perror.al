# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 512 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/perror.al)"
sub perror {
    print STDERR "@_: " if @_;
    print STDERR $!,"\n";
}

# end of POSIX::perror
1;
