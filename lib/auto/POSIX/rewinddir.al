# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 303 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/rewinddir.al)"
sub rewinddir {
    usage "rewinddir(dirhandle)" if @_ != 1;
    CORE::rewinddir($_[0]);
}

# end of POSIX::rewinddir
1;
