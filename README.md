# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

* 要修正点
・artistコントローラにおいてbefore_actionが適用されず。そのため、フレンドリーフォワーディングは未実装(コードは実装済み).
・navbarのjqueryが動かず。ドロップダウンメニューをナビバーに表示する暫定処理を実施。
・artist_indexページにてrender @artistsとすると<li>タグのレイアウトが崩れるため未実施
・adminテスト未実装
・postの投稿が現在はtoppageにあるが個別のアーティスページに設置すべき
・feedの未実装
・画像投稿の未実装