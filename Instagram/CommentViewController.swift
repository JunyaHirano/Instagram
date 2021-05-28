//
//  CommentViewController.swift
//  Instagram
//
//  Created by DS_JH on 2021/05/25.
//

import UIKit
import Firebase
import FirebaseUI
import SVProgressHUD

class CommentViewController: UIViewController {
    
    //コメント画面の画像
    @IBOutlet weak var imageView: UIImageView!
    //コメント入力複数行テキスト
    @IBOutlet weak var commentView: UITextView!
    
    //コメントするボタン
    @IBAction func handleCommentButton(_ sender: Any) {
    }
    //キャンセルボタン
    @IBAction func handleCancelBUtton(_ sender:Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
