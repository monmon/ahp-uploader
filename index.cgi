#!/usr/local/bin/perl -w
BEGIN { unshift @INC, "lib" };

use strict;
use CGI;
use CGI::Carp qw(fatalsToBrowser);

# 設定
my $get_config = sub {
    my $q = shift or return;
    
    my $cgi_url = $q->url;
    my($home_num, $user) = ($1, $2) if $cgi_url =~ m{http://hpcgi([0-9])\.nifty\.com/([^/]+)/};
    my $domain           = sprintf('https://homepage%s.nifty.com', $home_num);
    my $base_name        = 'uploader';
    my $src_uploader_dir = "private/$base_name";
    my $uploader_dir     = "/$src_uploader_dir";
    my $json_file_path   = sprintf('%s/data.json', $uploader_dir);
    my $jsonp_file_path  = $json_file_path . 'p';
    my $jsonp_url_path   = $1 if $jsonp_file_path =~ m{^/private/(.*)$}xms;

    +{
        cgi_url          => $cgi_url,
        domain           => $domain,
        base_name        => $base_name,
        user             => $user,
        src_uploader_dir => $src_uploader_dir,
        uploader_dir     => $uploader_dir,
        json_file_path   => $json_file_path,
        jsonp_file_path  => $jsonp_file_path,
        jsonp_url_path   => $jsonp_url_path,
    };
};


my $q = CGI->new;
my $config = $get_config->($q);
my($content_type, $content) = MyApp->new($q, $config)->dispatch;

print
   $q->header( -type => $content_type, -charset => 'UTF-8', ),
   $content;


package MyApp;
use strict;

sub new {
    my $class = shift;
    my $q = shift;
    my $config = shift;
    
    my $self = bless {
        q         => $q,
        path_info => '/',   # dummy
        config    => $config,
    }, $class;
}

# $qを触るのはcontrollerだけ
sub dispatch {
    my $self = shift;
    my $q = shift || $self->{q};                # newのとき以外の値を使いたい場合は引数で指定
    my $config = shift || $self->{config};      # newのとき以外の値を使いたい場合は引数で指定

    $self->{path_info} = $q->path_info || '/';
    my $con = $self->_controller();

    #$con->req($self->request);
    #$con->res(MyApp::Response->new);
    #$con->view(MyApp::View->new({ path_segments => [ $self->path_segments ] }));

    $con->handle_request($q, $config);

    #$con->res;
}

sub _controller {
    my $self = shift;
    
    my $handler = join '::', 'MyApp', 'Controller', map {
        ucfirst
    } $self->_path_segments();

    $self->_require($handler)   or die $@;
    $handler->new;
}

sub _path_segments {
    my $self = shift;
    my $path_info = $self->{path_info};

    my @path_segments = split '/', $path_info;
    shift @path_segments;

    push @path_segments, 'index' unless @path_segments;

    @path_segments;
}

# instead of UNIVERSAL::require
sub _require {
    my $self = shift;
    my $module = shift;
    
    my $file = $module . '.pm';
    $file =~ s{::}{/}g;

    return eval { 1 } if $INC{$file};

    my $return = eval qq{
        CORE::require(\$file);
    };
}

1;
