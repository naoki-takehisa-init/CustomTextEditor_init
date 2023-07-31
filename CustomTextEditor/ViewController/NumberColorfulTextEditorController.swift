//
//  NumberColorfulTextEditorController.swift
//  CustomTextEditor
//
//  Created by 武久 なおき on 2023/07/31.
//

import Foundation
import UIKit

/// 数字カスタムエディタ.
class NumberColorfulTextEditorController: UIViewController, UITextViewDelegate {
    
    // テキストエディター
    @IBOutlet weak var textNumberColorful: UITextView!
    // プレースホルダ
    @IBOutlet weak var placeholder: UILabel!
    
    /// ナンバーカラーの配列.
    let numberColor: [UIColor] = [.red,.orange,.yellow,.green,.blue,.cyan,.purple,.magenta,.systemTeal]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初期値を代入
        textNumberColorful.text = ""
        // プレースホルダーに表示する内容を代入
        placeholder.text = "数字だけランダムで色がつきます"
        // UITextViewのDelegateを設定している
        textNumberColorful.delegate = self
        // オートレイアウトを使用するためfalse
        textNumberColorful.translatesAutoresizingMaskIntoConstraints = false
        // 親にViewを追加する
        view.addSubview(textNumberColorful)
        view.addSubview(placeholder)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // textViewに値を入れたらプレースホルダーを空にする
        if textView.text == "" {
            placeholder.text = "数字だけランダムで色がつきます"
        } else {
            placeholder.text = ""
        }
        // テキストViewのオプショナルをアンラップします
        if let text = textView.text {
            // 受け取った文字列を属性付き文字列として変換し代入
            let attributedString = NSMutableAttributedString(string: textView.text)
            // 数字のみを抽出する文字セット(CharacterSet)を定義する
            let digitCharacterSet = CharacterSet.decimalDigits
            // 検知するスタートのインデックス
            // 同じところをぐるぐるしないように変数を作っておく必要がある
            var start = text.startIndex
            // 文字数制限以降の文字の範囲を取得
            while let range = text.rangeOfCharacter(from: digitCharacterSet, options: .literal, range: start..<text.endIndex) {
                // 配列に入れたUIColorをランダムで代入します
                let randomColor = numberColor.randomElement()
                // 数字のみの範囲を設定
                let digitRange = NSRange(range, in: text)
                // 数字のみの文字色をランダム色で変更する
                attributedString.addAttribute(.foregroundColor, value: randomColor!, range: digitRange)
                // 次の処理が行われるスタートインデックスを設定
                start = range.upperBound
            }
            // 上記の処理が終わるとtextViewに代入される
            textView.attributedText = attributedString
        }
    }
}
