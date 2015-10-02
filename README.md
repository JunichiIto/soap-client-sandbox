# soap-client-sandbox

SOAP通信 + SSLクライアント証明書の実験をするためのRailsアプリケーション（クライアント側）

## Setup

1. CAの作成と各種証明書の作成を行う
  - [Ben Vandgrift | Secure Communication for Rails Applications (2)](http://ben.vandgrift.com/2011/05/13/secure_communication_rails_2.html) のThe Easy Wayを参照。
2. 1で作成した証明書と秘密鍵を配置する
  - `ssl/newcert.pem`
  - `ssl/newkey.pem`
3. config/settings.local.ymlに証明書のパスワードを設定する
  - http://keep-up-with-tech.blogspot.jp/2013/03/ruby.html を参考にして暗号化し、複合化に必要な情報を設定する
  - 設定例は config/settings.yml を参照。
4. [soap-server-sandbox](https://github.com/JunichiIto/soap-server-sandbox) をセットアップ＆起動する
  - https://localhost:3443/rumbas/wsdl にアクセスできるようにする
5. テストがパスすることを確認する
  - `bin/rake db:migrate`
  - `bin/rake test`