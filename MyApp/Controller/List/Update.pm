package MyApp::Controller::List::Update;
use strict;

sub new {
    my $class = shift;
    bless {}, $class;
}

sub handle_request {
    my $self = shift;
    my($q, $config) = @_;
    
    my $content_type = 'application/x-javascript';

    my %update_data_of = $q->param;
    my $update_data_of_ref = $q->Vars;
    my $content = MyApp::Accessor::List::Update->get_content({
        cb                 => $q->param('cb') || 'updateData',
        id                 => $q->param('id') || undef,
        update_data_of_ref => \%update_data_of,
        update_data_of_ref => $update_data_of_ref,
        %{$config},
    });
    
    ($content_type, $content);
}

1;



package MyApp::Accessor::List::Update;
use strict;
use MyApp::FileManager;

sub get_content {
    my $class = shift;
    my $stuff = shift;

    my $json_file_path     = delete $stuff->{json_file_path}     or die;
    my $id                 = delete $stuff->{id}                 or die;
    my $update_data_of_ref = delete $stuff->{update_data_of_ref} or die;
    my $cb                 = delete $stuff->{cb} || 'cb';

    my %update_data_of;
    for my $key (%{$update_data_of_ref}) {
        next if $key !~ m/^(?:file|label|pass)$/;
        $update_data_of{$key} = $update_data_of_ref->{$key};
    }

    my $manager = MyApp::FileManager->new($json_file_path);
    my $res = $manager->write($id, {
        %update_data_of,
    });

    "$cb($res)";
}


1;
