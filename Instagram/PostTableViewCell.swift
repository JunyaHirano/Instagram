//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by DS_JH on 2021/05/11.
//

import UIKit
import FirebaseUI

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    //コメントするボタン 追加 homeviewコントローラーで追加するためactionでなくoutlet
    @IBOutlet weak var commentButton: UIButton!
    //コメント表示ラベル追加
    @IBOutlet weak var commentLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //PostDataの内容をセルに表示
    func setPostData(_ postData: PostData){
        //画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
        //キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
//       // forで配列をcommentAllに代入しようとしたがエラーになり、やりかたがワカラナカイのでjoinedを使うことにした ⭐課題
//        var commentAll: String?
//        for value in postData.comment {
//            commentAll! += value
//        }
//        //コメントの表示
//        self.commentLabel.text = commentAll
        
        // 配列の値をjoinedで結合してコメントを追加 ⭐課題
        self.commentLabel.text =  postData.comment.joined(separator: "\n\n")
        
        //日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }
        
        //いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        //いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for:.normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
    
}
