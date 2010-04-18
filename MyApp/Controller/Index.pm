package MyApp::Controller::Index;
use strict;

sub new {
    my $class = shift;
    bless {}, $class;
}

sub handle_request {
    my $self = shift;
    my($q, $config) = @_;
    
    my $content_type = 'text/html';

    my $index = MyApp::Accessor::Index->new($config);

    ($content_type, $index->get_content);
}

1;



package MyApp::Accessor::Index;
use strict;
use Symbol qw(gensym);
use MyApp::FileManager;

sub new {
    my $class = shift;
    my $stuff = shift;

    my $cgi_url          = delete $stuff->{cgi_url}          or die;
    my $domain           = delete $stuff->{domain}           or die;
    my $base_name        = delete $stuff->{base_name}        or die;
    my $user             = delete $stuff->{user}             or die;
    my $src_uploader_dir = delete $stuff->{src_uploader_dir} or die;
    my $uploader_dir     = delete $stuff->{uploader_dir}     or die;

    bless {
        cgi_url          => $cgi_url,
	domain           => $domain,
	base_name        => $base_name,
	user             => $user,
	src_uploader_dir => $src_uploader_dir,
	uploader_dir     => $uploader_dir,
    }, $class;
}

sub get_content {
    my $self = shift;

    my($cgi_url, $uploader_dir, $file_name, $domain, $base_name, $user)
        = @{$self}{'cgi_url', 'uploader_dir', 'file_name', 'domain', 'base_name', 'user'};

    my $manager = MyApp::FileManager->new;

    return << "END_OF_HTML"
<!DOCTYPE html>  
<html lang="ja">  
<head>  
  <meta charset="utf-8"> 
</head>
<body>
<h1>アップローダ</h1>
<h2>はじめに</h2>
<p>
<a href="$cgi_url/install">こちら</a>からインストール
</p>
<h2>ファイルのアップロード、ダウンロード方法</h2>
<ol>
  <li>
ftpで「$manager->{data_dir_path}」配下にファイルをアップロードする<br>
<ul>
<li>
※ファイル名は日本語は対応してないので、アップロードするときは英数字のファイル名にする<br>
例）「資料.zip」ではなく「shiryou-1.zip」などのファイル名にする
</li>
</ul>
  </li>
  <li>
  <a href="$domain/$user/$base_name/">ファイル一覧のページ</a>でファイルのダウンロード用パスワードを設定する
  </li>
  <li>
ダウンロード用リンクからファイルをダウンロードする
  </li>
  <li>
いらなくなったファイルはftpで削除する
  </li>
</ol>
</body>
</html>
END_OF_HTML
}


1;
