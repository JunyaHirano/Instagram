//
//  PostData.swift
//  Instagram
//
//  Created by DS_JH on 2021/05/11.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    //コメント追加 ⭐ 配列で定義
    var comment: [String] = [ ]
    
    init(document: QueryDocumentSnapshot){
        self.id = document.documentID
        
        let postDic = document.data()
        
        self.name = postDic["name"] as? String
        
        self.caption = postDic["caption"] as? String
        
        //課題・コメント追加⭐
        if let comment = postDic["comment"] as? [String] {
            self.comment = comment
        }
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid {
            //likesの配列の中にmyidが含まれているかチェックすることで自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                //myidがあればいいねをおしていると認識する
                self.isLiked = true
            }
        }
    }
    
}
