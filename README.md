# emacsclient focus

These scripts are developing in `https://github.com/syohex/emacs-utils`

## 機能
(server-start)を実行した Emacsと異なる仮想デスクトップで emacsclientを
実行した場合でも, フォーカスを切り替える.

## 必須パッケージ
* wmctrl

```
#Ubuntuの場合
% sudo aptitude install wmctrl
```

## 設定
.emacsに以下を追加する.

```elisp
(when (string-equal system-type "gnu/linux")
  (defadvice server-start
    (after server-start-after-write-window-id ())
    (call-process "emacs_serverstart.pl"
                  nil nil nil
                  (number-to-string (emacs-pid))
                  (if window-system
                      "x"
                    "nox")))
  (ad-activate 'server-start))
```

以下のファイルを PATHの通ったディレクトリに置く
* emacs_serverstart.pl
*  emacsclient.sh

これで準備完了

## 使い方
  emacsclientの代わりに emacsclient.shを使う.
