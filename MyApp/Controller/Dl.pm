package MyApp::Controller::Dl;
use strict;

sub new {
    my $class = shift;
    bless {}, $class;
}

sub handle_request {
    my $self = shift;
    my($q, $config) = @_;
    
    my $dl = MyApp::Accessor::Dl->new({
        id   => $q->param('id') || undef,
        pass => $q->param('pass') || undef,
        %{$config},
    });

    if ($dl->can_download) {      # download OK
        # ieの場合だけURLエンコード
        my $ua = $q->user_agent;
        my $filename = ($ua =~ m{MSIE}) ? __url_encode($dl->{label} || $dl->{id})
                     :                    $dl->{label} || $dl->{id}
                     ;

        print $q->header(
            -type                => 'application/octet-stream',
            -Content_Disposition => sprintf("attachment; filename=%s", $filename),
        );
        $dl->process;
    }
    else {                        # show passward field
        ('text/html', $dl->get_content);
    }
}

sub __url_encode {
    my $encode = shift;
    return () unless defined $encode;
    $encode
        =~ s/([^A-Za-z0-9\-_.!~*'() ])/ uc sprintf "%%%02x",ord $1 /eg;
    $encode =~ tr/ /+/;
    return $encode;
}

1;






package MyApp::Accessor::Dl;
use strict;
use File::Copy;
use Symbol qw(gensym);
use MyApp::FileManager;
use MyApp::Encrypt;

sub new {
    my $class = shift;
    my $stuff = shift;

    my $id             = delete $stuff->{id}                 or die "no id";
    my $pass           = delete $stuff->{pass};
    my $json_file_path = delete $stuff->{json_file_path};

    my $manager = MyApp::FileManager->new($json_file_path);

    bless {
	id              => $id,
	pass            => $pass,
        file            => undef,
        label           => undef,
	json_file_path  => $json_file_path,
	manager         => $manager,
    }, $class;
}

sub can_download {
    my $self = shift;
    $self->{id} = $_[0] if $_[0];
    $self->{pass} = $_[1] if $_[1];

    my $id = $self->{id};
    my $pass = $self->{pass};

    my $file_of_ref = $self->{manager}->read();
    return unless exists $file_of_ref->{$id}; # idが存在しなければ抜ける
    
    my $target_file_ref = $file_of_ref->{$id};
    $self->{label} = $target_file_ref->{label};
    $self->{file} = $target_file_ref->{file};
    return unless $pass;    # passがなければshow password field
    return unless $target_file_ref->{pass}; # passが設定されてなければダメ
    return $self->{pass} eq $target_file_ref->{pass};
}

sub process {
    my $self = shift;
    return unless $self->can_download;   # 念のためチェック

    my $size = 1024;
    my $rfh = gensym;
    open $rfh, "< $self->{file}"  
	or die "cannot open file $self->{file}: $!";
    print while read $rfh, $_, $size;
    close $rfh;

    die;
}

sub get_content {
    my $self = shift;
    $self->{id} = $_[0] if $_[0];

    return << "END_OF_HTML";
<html>
<body>
<p>
「$self->{label}」をダウンロードするためのパスワードを入力してください。
</p>
 <form action="./dl" method="GET">
   <input type="text" name="pass" value="input password" onfocus="this.value='';this.style.color=''" style="color: #ccc;">
   <input type="hidden" name="id" value="$self->{id}">
   <input type="submit" value="download">
 </form>
</body>
</html>
END_OF_HTML
}

1;

__END__
