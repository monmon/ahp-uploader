package MyApp::FileManager;
use strict;
use Carp;
use Symbol qw(gensym);
use JSON qw();
use MyApp::Encrypt;
use vars qw($SALT $FILE_PATH);

# global
$SALT = 'p7';    # 適当
$FILE_PATH = '/private/uploder/data.json';

sub new {
    my $class = shift;
    my $json_path = shift || $FILE_PATH;

    my $data_dir_path = $json_path;
    $data_dir_path =~ s{\.json}{};    # data_dir_pathは.jsonを除いた名前

    bless {
        json_h => JSON->new,
        data_dir_path => $data_dir_path,
        json_path => $json_path,
    }, $class;
}

sub write {
    my $self = shift;
    my $file_id = shift;
    my $update_data = shift; # hashRef
    
    my $file_of_ref = $self->_read_json_data;  # 既に登録済みのファイルリスト

    # file_idがあれば、updateしたいものだけ上書き
    $file_of_ref->{$file_id} = {
        %{$file_of_ref->{$file_id}},
        %{$update_data},
    } if $file_of_ref->{$file_id};

    $self->_write_json_data($file_of_ref);

    $self->{json_h}->objToJson({
        $file_id => $update_data,
    });
}

sub read {
    my $self = shift;
    my $is_json = shift || 0; # jsonとして出力したいかどうか

    my $file_of_ref = $self->_read_json_data;  # 既に登録済みのファイルリスト

    my %file_of; # 新リスト
    my @files = $self->_get_file_list; # 実際にあるファイルリスト
    for my $file_name (@files) {
        my $file_id = $self->_get_file_id($file_name);
        if ($file_of_ref->{$file_id}) {
            $file_of{$file_id} = $file_of_ref->{$file_id};
        }
        else {
            $file_of{$file_id} = {
                file => sprintf("%s/%s", $self->{data_dir_path}, $file_name),
                label => $file_name,
                pass => undef,
            };
        }
    }

    my $js = $self->_write_json_data(\%file_of); # 新リストを書き込み
    return ($is_json) ? $js: \%file_of;
}

sub _get_file_id {
    my $self = shift;
    my $file_name = shift;
    my $salt = shift || $SALT;

    my $id = MyApp::Encrypt::passwd($file_name, $salt);
    $id =~ s{[^a-zA-Z0-9]}{}g;
    $id;
}

sub _get_file_list {
    my $self = shift;
    
    do{
        my $dh = gensym;
        opendir $dh, $self->{data_dir_path} or return;
#        my @f = grep !/^\./, readdir($dh);
        my @f = grep /^[^\.][a-zA-Z0-9\.\#\(\)\[\]{}+-=_~$%']*$/, readdir($dh);
        closedir $dh;

        @f;
    };
}

sub _read_json_data {
    my $self = shift;
    my $json_path = shift || $self->{json_path};

    # 5.005.02 なのでopenは 2引数
    my $rfh = gensym;
    open $rfh, "< $json_path"   or die "cannot open read file $json_path: $!";
    my $js = do { local $/; <$rfh> };
    close $rfh;

    $self->{json_h}->jsonToObj($js); # データを復元
}

sub _write_json_data {
    my $self = shift;
    my $file_of_ref = shift;
    my $json_path = shift || $self->{json_path};

    my $js = $self->{json_h}->objToJson($file_of_ref, {
        pretty => 1,
        indent => 4,
        delimite => 2,
    });
    my $wfh = gensym;
    open $wfh, "> $json_path"   or croak "cannot open file $json_path: $!";
    print {$wfh} $js;
    close $wfh;

    $js;
}

1;
