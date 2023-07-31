//
//  HomeViewController.swift
//  CustomTextEditor
//
//  Created by 武久 なおき on 2023/07/27.
//

import Foundation
import UIKit

/// メイン画面.
class HomeViewController: UIViewController {
    
    // メインUIView
    @IBOutlet var homeView: UIView!
    
    override func viewDidLoad() {
        // ContainerViewを使うことによりメイン画面のViewControllerはすっきりと使うことができる
        // 分かりやすく背景をグレイで
        homeView.backgroundColor = .darkGray
    }
}
