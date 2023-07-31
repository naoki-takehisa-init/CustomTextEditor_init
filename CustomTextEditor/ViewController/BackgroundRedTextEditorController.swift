//
//  BackgroundRedTextEditorController.swift
//  CustomTextEditor
//
//  Created by 武久 なおき on 2023/07/26.
//

import Foundation
import UIKit

/// 背景カスタムエディタ.
class BackgroundRedTextEditorController: UIViewController, UITextViewDelegate {
    
    // テキストエディター
    @IBOutlet weak var textBackgroundRed: UITextView!
    // プレースホルダ
    @IBOutlet weak var placeholder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初期値を代入
        textBackgroundRed.text = ""
        // プレースホルダーに表示する内容を代入
        placeholder.text = "文字数を超過すると背景が赤くなります"
        // UITextViewのDelegateを設定している
        textBackgroundRed.delegate = self
        // オートレイアウトを使用するためfalse
        textBackgroundRed.translatesAutoresizingMaskIntoConstraints = false
        // 親にViewを追加する
        view.addSubview(textBackgroundRed)
        view.addSubview(placeholder)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            placeholder.text = "文字数を超過すると背景が赤くなります"
        } else {
            placeholder.text = ""
        }
        // テキストViewのオプショナルをアンラップします
        if let text = textView.text {
            // Twitter(X)と同じ140文字制限
            // 正しくは全角140文字、半角280文字だが割愛します
            let characterLimit = 5
            // 制限を超えた場合
            if text.count > characterLimit {
                // 受け取った文字列を属性付き文字列として変換し代入
                let attributedString = NSMutableAttributedString(string: text)
                // 文字数制限以降の文字の範囲を取得
                let range = NSRange(location: characterLimit, length: text.count - characterLimit)
                // 作成した属性付き文字列に変更を加える(今回は140字以降は背景色が赤になる)
                attributedString.addAttribute(.backgroundColor, value: UIColor.red, range: range)
                // スタイル付きのテキスト、attributedTextプロパティに変更を加えたものを代入
                textView.attributedText = attributedString
                // 制限を超えていない場合
            } else {
                // 受け取った文字列を属性付き文字列として変換し代入
                let attributedString = NSAttributedString(string: text)
                // そのままattributedTextプロパティへ代入
                textView.attributedText = attributedString
            }
        }
    }
}
