# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 290 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/opendir.al)"
sub opendir {
    usage "opendir(directory)" if @_ != 1;
    my $dirhandle = gensym;
    CORE::opendir($dirhandle, $_[0])
	? $dirhandle
	: undef;
}

# end of POSIX::opendir
1;
