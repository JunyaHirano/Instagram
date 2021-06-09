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

//⭐課題
class CommentViewController: UIViewController , UITextFieldDelegate  {
    
    //コメント画面の画像
    @IBOutlet weak var commentImageView: UIImageView!
    
    //コメント入力複数行テキスト
    @IBOutlet weak var commentTextView: UITextView!
    
    //前画面からデータを受け取るための変数
    var postDataReceived: PostData?
    
    
    //コメント確定送信ボタン
    @IBAction func handleCommentButton(_ sender: Any) {
        // 前画面から受け取ったデータを取り出す
        guard let postData = postDataReceived else {
            print("nilならデバッグで表示される。表示されたらエラーで値が渡ってないということ")
            return //nilならreturn
        }
        print("DEBUG_PRINT: コメント投稿へすすんだ")
        
        //コメントユーザー名を取得  コメントの更新データを作成して更新する
        var postedName = Auth.auth().currentUser?.displayName
        //ユーザー名の最後にコロンをつける （本当はコメントにユーザー名をいれず、「辞書」にしてコメントユーザー名とコメントをセットにして出すのが良さそう）
        postedName! = postedName! + "："
        //コロンのついたユーザー名とコメントを結合
        let commentUserAndText = postedName! + self.commentTextView.text
        print("DEBUG_PRINT: コメントユーザー名とコメントがあるか確認 \(commentUserAndText)")
        
        //FieldValue.arrayUnionでコメントをFirebaseに保存する
        var updateValue: FieldValue?
        updateValue =   FieldValue.arrayUnion([commentUserAndText])
        // 保存場所の定義
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        //commentに更新データを書き込む
        postRef.updateData(["comment" : updateValue!])

            // XXX FireStoreに投稿データを保存しようとしたがく他の配列データがすべて消えたので以下の記載の仕方はNG
            // let postDic = ["comment" : self.commentTextView.text!] as [String : Any]
            // postRef.setData(postDic)

        // 画面を閉じて戻る
         self.dismiss(animated: true, completion:nil)
     }

    //setPostDataメソッド（HomeViewControllerテーブル表示処理から呼び出されるが画面的に不要ぽい。消しても影響なし）
    //    func setPostData(_ postData: PostData) {
    //        postDataReceived = postData
    //    }
    
    //画面表示前に呼び出されるメソッド。遷移後に一度呼ばれ、他の画面遷移から戻ってきた時にも再度呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let postData = postDataReceived else {
            print("nilならデバッグで表示される。表示されたらエラーで値が渡ってないということ")
            return //nilならreturn
        }
        //nilでなければ以下表示
        //イメージ画像を取得
        commentImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        commentImageView.sd_setImage(with: imageRef)
   }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //キャンセルボタンを押した時のメソッド
    @IBAction func handleCancelBUtton(_ sender:Any) {
        //画面を閉じて戻る
        self.dismiss(animated: true, completion:nil)
    }
}
