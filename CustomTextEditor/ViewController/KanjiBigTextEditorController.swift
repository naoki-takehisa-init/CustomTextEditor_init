//
//  KanjiBigTextEditorController.swift
//  CustomTextEditor
//
//  Created by 武久 なおき on 2023/07/31.
//

import Foundation
import UIKit

/// 漢字カスタムエディタ.
class KanjiBigTextEditorController: UIViewController, UITextViewDelegate {
    
    // テキストエディター
    @IBOutlet weak var textKanjiBig: UITextView!
    // プレースホルダ
    @IBOutlet weak var placeholder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初期値を代入
        textKanjiBig.text = ""
        // プレースホルダーに表示する内容を代入
        placeholder.text = "漢字だけ大きくなります"
        // UITextViewのDelegateを設定している
        textKanjiBig.delegate = self
        // オートレイアウトを使用するためfalse
        textKanjiBig.translatesAutoresizingMaskIntoConstraints = false
        // 親にViewを追加する
        view.addSubview(textKanjiBig)
        view.addSubview(placeholder)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            placeholder.text = "漢字だけ大きくなります"
        } else {
            placeholder.text = ""
        }
        // テキストViewのオプショナルをアンラップします
        if let text = textView.text {
            // 漢字の範囲を取得してフォントサイズを設定
            // 受け取った文字列を属性付き文字列として変換し代入
            let attributedString = NSMutableAttributedString(string: textView.text)
            // 正規表現パターンで漢字を検索
            //p{Han}はUnicodeで漢字の範囲を表す特殊な文字クラス
            let regexPattern = "\\p{Han}+"
            // 正規表現を表すオブジェクト(NSRegularExpression)で検索用のオブジェクトを定義
            let regex = try! NSRegularExpression(pattern: regexPattern, options: [])
            // 検索用オブジェクトで漢字のみを抽出
            let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
            // フォントサイズを指定
            let bigFont = UIFont.systemFont(ofSize: 24)
            // 抽出した漢字のフォントサイズを変更する
            for match in matches {
                let range = match.range
                attributedString.addAttribute(.font, value: bigFont, range: range)
            }
            // 変更が終わるとtextViewに代入される
            textView.attributedText = attributedString
        }
    }
}
