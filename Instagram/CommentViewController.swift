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

class CommentViewController: UIViewController , UITextFieldDelegate  {
    
    //コメント画面の画像
    @IBOutlet weak var commentImageView: UIImageView!
    //コメント入力複数行テキスト
    @IBOutlet weak var commentView: UITextView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    //コメント確定送信ボタン
    @IBAction func handleCommentButton(_ sender: Any) {
        }
    //キャンセルボタン
    @IBAction func handleCancelBUtton(_ sender:Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    //前画面からデータを受け取るための変数
    var postDataReceived: PostData?

    //setPostDataメソッド（HomeViewControllerテーブル表示処理から呼び出されるが画面的に不要？）
    func setPostData(_ postData: PostData) {
        postDataReceived = postData
    }
    
    //画面表示前に呼び出されるメソッド。遷移後に一度呼ばれ、他の画面遷移から戻ってきた時にも再度呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let postData = postDataReceived else {
            print("nilならデバッグで表示")
            return //nilならreturn
        }
        //ここから↓動いてなさげ
        //イメージ画像
        commentImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        commentImageView.sd_setImage(with: imageRef)
        //キャプションのテキスト（テスト）
        self.commentLabel.text = "\(postData.name!) : \(postData.caption!)"
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
