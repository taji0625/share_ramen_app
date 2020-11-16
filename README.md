# シェアラー
「おすすめラーメンを発見・共有しよう！」  

好きなラーメン・食べたラーメンをシェアすることで、ラーメン店の情報を共有でき、ユーザー同士が交流できることを目的にしたアプリです。  


![775F993E-6C9B-4F70-BE79-B618CE66B601_1_105_c](https://user-images.githubusercontent.com/63524359/95813830-baa8bf80-0d53-11eb-9d65-c9cf847e71c3.jpeg)


# URL
https://www.share-ramen-app.com    

【ログイン】ページ内にゲストログインボタンを配置しており、簡単にログインできます。  


# 制作の背景

私はラーメンが好きです。在住している県内や近隣県はもちろん、旅行先などでも行く先々でラーメン店を探して食べに行くほどです。   
そこで自分自身が美味しいと思ったラーメンをシェアしたり、自分の知らないラーメン店を発見できたりするラーメン専用のSNSのようなアプリがあれば、「ラーメンが好きな方同志の交流ができたり、新型コロナウイルスの影響で大きく打撃を受けているラーメン店に足を運ぶ機会も増えるのでは？」と思い制作いたしました。



# 使用技術
### フロントエンド
- HTML 
- Sass  
- JavaScript
- JQuery
- Bootstrap  
### バックエンド
- Ruby 2.6.5 
- Rails 6.0.3.2  
### データベース
- MySQL 8.0.21  
### 開発環境  
- Docker
### 本番環境
- AWS(EC2、VPC、S3、RDS for MySQL、Route53、ELB、ACM)  
- Nginx 
- Unicorn  
### その他
- RSpec(単体・結合テスト) (109exmples)
- Rubocop-airbnb(リンター)  
- CircleCIを用いて自動ビルド・自動テスト環境の構築
- AWS・ACMにてSSL証明書を発行しSSL化   


# 機能一覧
### ユーザー機能
- ユーザー登録・編集・削除（deviseを使用) 
- ゲストログイン 
- プロフィール画像の登録・編集（carrierwaveを使用） 
- プロフィール画像アップロード時のプレビュー 
- ユーザー詳細ページにて自分の投稿、食べたい！を押した投稿の一覧表示(タブで切替)  
### 投稿機能
- 新規投稿・編集・削除 
- ラーメン画像アップロード時のプレビュー 
- 未入力項目がある時のバリデーション  
### 食べたい！（いいね!）機能
- 非同期通信 
- 食べたい！を押したユーザー一覧ページ 
(ハートマークもしくはその隣の食べたい！数をクリック)  
### コメント機能
- 新規投稿・削除 
- 削除ができるのはコメントしたユーザーと、コメントされた投稿をしたユーザー  
### フォロー機能
- 非同期通信 
- 以下のページにフォロータグを配置 
  + ユーザー詳細ページ  
  + ユーザー一覧ページ  
  + 投稿詳細ページ  
  + 食べたい！を押したユーザー一覧ページ  
  + 通知一覧ページ(フォロー通知の場合のみ)
### 通知機能
- 以下のタイミングでユーザーに通知を送信  
  + 投稿に食べたい！を押された時 
  + 投稿にコメントされた時 
  + フォローされた時 
- 通知全削除機能 
- 未確認の通知がある場合は黄色のマークを表示  
### その他
- 検索機能(Ransackを使用) 
- レスポンシブ対応 
- deviseの日本語化(rails-i18n、devise-i18nを使用) 
- 以下のページでページネーションを採用(Kaminariを使用) 
  + 投稿一覧ページ 
  + 通知一覧ページ


# 工夫した点
- 直感的に操作しやすいUI/UXを意識しました。
- 「いいね！」ではなく「食べたい！」とし、オリジナリティを出しました。
- ロゴにも拘りオリジナリティを出しました。


# 躓いて克服した点
- AWSへのデプロイ  
  + AWSの知識が0の状態からのスタートだったため、かなり苦労ましたが、書籍や動画教材での学習と並行しながら進めていくことで少しずつ知識が深まり、デプロイに成功しました。
- Docker導入  
  + Rails6＋MySQLという組み合わせでの情報が少なかったため、苦労しましたが、試行錯誤しながらなんとか導入に成功しました。  
  **→Qiitaに[記事を投稿](https://qiita.com/takuma_0625/items/2a25dce50ad309993fa3)し、アプトプットしました。**

# AWS構成図
![2361849D-6F2D-4B96-8216-2A32E652E4BA](https://user-images.githubusercontent.com/63524359/99212611-d568cb00-280e-11eb-88c9-4dfd3f4ad8a2.jpeg)




# ER図
![CD04D5F3-2A2A-49C4-B3A0-A8CCE369152F](https://user-images.githubusercontent.com/63524359/95812808-2e959880-0d51-11eb-94c4-7436973261d6.jpeg)
