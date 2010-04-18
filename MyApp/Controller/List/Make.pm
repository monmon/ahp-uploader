package MyApp::Controller::List::Make;
use strict;

sub new {
    my $class = shift;
    bless {}, $class;
}

sub handle_request {
    my $self = shift;
    my($q, $config) = @_;
    
    my $content_type = 'application/x-javascript';

    my $cb = $q->param('cb') || 'makeTable';
    my $content = MyApp::Accessor::List::Make->get_content({
        cb     => $cb,
        %{$config},
    });

    return ($content_type, $content);
}

1;



package MyApp::Accessor::List::Make;
use strict;
use Symbol qw(gensym);
use MyApp::FileManager;


sub get_content {
    my $class = shift;
    my $stuff = shift;

    my $domain          = delete $stuff->{domain}          or die;
    my $user            = delete $stuff->{user}            or die;
    my $json_file_path  = delete $stuff->{json_file_path}  or die;
    my $jsonp_file_path = delete $stuff->{jsonp_file_path} or die;
    my $jsonp_url_path  = delete $stuff->{jsonp_url_path}  or die;
    my $cb              = delete $stuff->{cb} || 'cb';

    my $manager = MyApp::FileManager->new($json_file_path);
    my $is_json = 1;
    my $js = $manager->read($is_json);

    my $wfh = gensym;
    open $wfh, "> $jsonp_file_path"   or die "cannot open file $jsonp_file_path: $!";
    print {$wfh} $cb . "($js)";
    close $wfh;

    my $script = << "END_OF_JS";
(function(d) {
    var script = d.createElement('script');
    script.type = 'text/javascript';
    script.charset = 'utf-8';
    script.src = "$domain/$user/$jsonp_url_path";
    d.body.appendChild(script);
})(document);
END_OF_JS

    $script;
}

1;
