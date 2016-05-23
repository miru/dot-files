# これはなに？
個人のdotファイルとかよく使うスクリプトをリポジトリにいれているだけのディレクトリです。
使えそうならコピペしてパクっちゃえばいいんじゃないかな？

## 他の人でも使えそうなスクリプト

### narou_update.sh
[narou.rb](https://github.com/whiteleaf7/narou/wiki)を使って小説を更新して、[Pushbullet](https://www.pushbullet.com/)で更新を通知します。
更新対象はfreeze以外の全小説です。
変更すべき変数
- PUSHBULLET_TOKEN
-- Pushbulletのトークンです。ご自身のトークンに書き換えてください。
[Pushbulletのアカウント設定](https://www.pushbullet.com/#settings/account)で”Create Access Token”をポチっとすればトークンが得られます。
- NAROU_DIR
-- narou.rb initしたディレクトリを指定します。
私は ~/narou で narou.rb init していて、このディレクトリをdropboxで同期させています。
小説は更新はVPS上で定期実行し、PC上でnarou.rb webを起動しています。
web uiからKindleタグが付いた小説をまとめてKindleにsendしています。
自分では完璧じゃない？うふふん。と思っています。

### fastcheck_narou.sh
[narou.rb](https://github.com/whiteleaf7/narou/wiki)を使って小説を更新して、[Pushbullet](https://www.pushbullet.com/)で更新を通知します。
更新対象はデフォルトだとfastcheckというタグが付いた小説のみを更新します。
基本はnarou_update.shと同じですが更新対象を絞る事で動作を速くします。

 **[本好きの下剋上](http://ncode.syosetu.com/n4830bu/)のために作りました。神に感謝を！神に祈りを！**

### その他のファイル
過去の遺物。今はもう不要だけど残骸だけが残ってます。
