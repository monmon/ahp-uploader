package MyApp::Controller::Install;
use strict;

sub new {
    my $class = shift;
    bless {}, $class;
}

sub handle_request {
    my $self = shift;
    my($q, $config) = @_;
    
    my $content_type = 'text/html';

    my $file_name        = $q->param('file_name') || 'index.html';
    my $is_force_install = $q->param('is_force_install') || undef;
    my $index = MyApp::Accessor::Install->new({
	file_name        => $file_name,
	is_force_install => $is_force_install,
        %{$config},
    });

    ($content_type, $index->get_content);
}

1;



package MyApp::Accessor::Install;
use strict;
use Symbol qw(gensym);

sub new {
    my $class = shift;
    my $stuff = shift;

    my $cgi_url          = delete $stuff->{cgi_url}          or die;
    my $domain           = delete $stuff->{domain}           or die;
    my $base_name        = delete $stuff->{base_name}        or die;
    my $user             = delete $stuff->{user}             or die;
    my $src_uploader_dir = delete $stuff->{src_uploader_dir} or die;
    my $uploader_dir     = delete $stuff->{uploader_dir}     or die;
    my $file_name        = delete $stuff->{file_name}        or die;  
    my $is_force_install = delete $stuff->{is_force_install};

    bless {
        cgi_url          => $cgi_url,
	domain           => $domain,
	base_name        => $base_name,
	user             => $user,
	src_uploader_dir => $src_uploader_dir,
	uploader_dir     => $uploader_dir,
	file_name        => $file_name,
	is_force_install => $is_force_install,
    }, $class;
}

sub get_content {
    my $self = shift;

    my($cgi_url, $base_name, $src_uploader_dir, $uploader_dir, $file_name, $is_force_install)
        = @{$self}{'cgi_url', 'base_name', 'src_uploader_dir', 'uploader_dir', 'file_name', 'is_force_install'};

    my $message;
    # 既にディレクトリがあり、force_installでないなら初期化するかどうかを尋ねる
    if (-d $uploader_dir && !$is_force_install) {
	$message = << "END_OF_MESSAGE";
既にディレクトリが存在するけどホントに初期化する？
<a href="$cgi_url/install?is_force_install=1">初期化したい</a>
END_OF_MESSAGE
    }
    else {                   # ディレクトリがないので初期化
	mkdir $uploader_dir, 0775   or die "cannot mkdir $uploader_dir: $!"
	    unless -d $uploader_dir;
	$self->_copy_private($src_uploader_dir, $uploader_dir);     # private配下に必要なものをコピー
	$self->_make_index;       # index.htmlを作成

	$message = << "END_OF_MESSAGE";
<p>
初期設定が完了しました。<br>
続けてプライベートパックの設定をしてください。
</p>
<ol>
<li>
<a target="_blank" href="https://homepage.nifty.com/manage/ahp_mng_login.cgi">管理画面</a>へログインします。
</li>
<li>
左メニューの「オプション > プライベートパック」をクリックし、「設定する」をクリックします。
</li>
<li>
$base_nameのラジオボタンにチェックを入れて「次へ」をクリックします。
</li>
<li>
「ユーザー名」と「パスワード」に自分専用の名前とパスワードを入力して「設定する」をクリックして完了。<br>
※このユーザー名とパスワードは人に教えないでください。
</li>
<li>
あとは<a href="$self->{cgi_url}">元のページ</a>の流れに従ってください。
</li>
</ol>

END_OF_MESSAGE
    }

    return << "END_OF_HTML"
<!DOCTYPE html>  
<html lang="ja">  
<head>  
  <meta charset="utf-8"> 
</head>
<body>
$message
</body>
</html>
END_OF_HTML
}

sub _make_index {
    my $self = shift;

    my($cgi_url, $uploader_dir, $file_name)
        = @{$self}{'cgi_url', 'uploader_dir', 'file_name'};

    my $html = << "END_OF_HTML";
<!DOCTYPE html>  
<html lang="ja">  
<head>  
   <meta charset="utf-8"> 
   <style type="text/css">
tr, th, td {
    border: #eee 1px solid;
    padding: 0 20px;
}
th {
    background-color: #ccc;
}
.hidden {
    display: none;
}
   </style>
</head>
<body>
  <img id="loading" src="loading.gif" alt="" title="" style="display:none;">
  <div id="fileList">
  <p>
  <strong>ファイルをアップロードするとここに一覧が表示されます</strong>
  </p>
  </div>
<div>
<ul>
<li>
マス目をクリックすると項目修正モードになります。<br>
  <ul>
    <li>
決定：「Enter」を押す
    </li>
    <li>
キャンセル：マス目のスペースをクリック
    </li>
  </ul>
</li>
<li>
ダウンロード時のファイル名を日本語にすることも可能です。<br>
  <ul>
    <li>
例）「shiryou.zip」→「資料.zip」
    </li>
  </ul>
</li>
<li>
「ダウンロード用パスワード」には英数字を入力してください。<br>
</li>
<li>
リンクをクリックすればダウンロード用ページが開きます。<br>
  <ul>
    <li>
人に教える時はリンクを右クリックしてリンクをコピーしてください
    </li>
  </ul>
</li>
</ul>
</div>

<script type="text/javascript" src="jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="uploader-table.js"></script>
<script type="text/javascript">
UploaderTable.cgi = '$cgi_url';
</script>
<script type="text/javascript" src="$cgi_url/list/make?cb=UploaderTable.make"></script>

</body>
</html>
END_OF_HTML

    my $file_path = sprintf('%s/%s', $uploader_dir, $file_name);
    my $wfh = gensym;
    open $wfh, "> $file_path"   or die "cannot open file $file_path: $!";
    print {$wfh} $html;
    close $wfh;
}

sub _copy_private {
    my $self = shift;
    my($src_dir, $dest_dir) = @_;
    my @files = do{
	my $dh = gensym;
	opendir $dh, $src_dir or return;
	my @f = grep !/^\./, readdir($dh);
	closedir $dh;
	@f;
    };

    for my $file (@files) {
	my($src_path, $dest_path) = ("$src_dir/$file", "$dest_dir/$file");
	if (-d $src_path) {            # dir
	    mkdir $dest_path, 0777      or die "cannot mkdir $dest_path: $!"
		unless -d $dest_path;
	}
	else {                         # file
	    __cp($src_path, $dest_path);
	}
    }
}

sub __cp {
    my($src, $dest) = @_;
    my $rfh = gensym;
    my $wfh = gensym;
    open $rfh, "< $src";
    open $wfh, "> $dest";
    binmode $rfh;
    binmode $wfh;
    print {$wfh} do { local $/; <$rfh> };
    close $rfh;
    close $wfh;
}

1;
