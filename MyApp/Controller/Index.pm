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
<ol>
  <li>
<a href="$cgi_url/install">インストールする</a>
  </li>
  <li>
ftpで「$manager->{data_dir_path}」配下にファイルをアップロードする<br>
※日本語ファイルはダメ。あとで修正できるのでその時に日本語にする
  </li>
  <li>
  <a href="$domain/$user/$base_name/">ファイル一覧のページ</a>でファイルのダウンロード用パスワードを設定する
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
