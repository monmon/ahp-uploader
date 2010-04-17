# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 507 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/gets.al)"
sub gets {
    usage "gets()" if @_ != 0;
    scalar <STDIN>;
}

# end of POSIX::gets
1;
