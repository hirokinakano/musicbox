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

## 要修正点
- artistコントローラにおいてbefore_actionが適用されず。そのため、フレンドリーフォワーディングは未実装(コードは実装済み).
- navbarのjqueryが動かず。ドロップダウンメニューをナビバーに表示する暫定処理を実施。
- artist_indexページにてrender @artistsとすると<li>タグのレイアウトが崩れるため未実施
- adminテスト未実装
- postの投稿が現在はtoppageにあるが個別のアーティスページに設置すべき
- post_interface.testのdeleteの確認テストを削除（メモに残してあります）

## タスク
- artist/editの紹介文（content）の文字数制限を表示
- artistのプロフィール画像をgravatarから通常のimageに変更
- pullrequestおよびissueの理解