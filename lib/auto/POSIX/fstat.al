# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 750 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/fstat.al)"
sub fstat {
    usage "fstat(fd)" if @_ != 1;
    local *TMP;
    open(TMP, "<&$_[0]");		# Gross.
    my @l = CORE::stat(TMP);
    close(TMP);
    @l;
}

# end of POSIX::fstat
1;
