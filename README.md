# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.7.3

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

*Webpacker::Manifest::MissingEntryErrorがでた時の対処法
以下のコマンドをSpot下で実行してください。 
rails webpacker:install
rails webpacker:compile
また、上記の方法で解決しない場合はnode.jsのバージョンが合っていない場合があります。
