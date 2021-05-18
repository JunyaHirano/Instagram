//
//  TabBarController.swift
//  Instagram
//
//  Created by DS_JH on 2021/05/09.
//

import UIKit
import Firebase //先頭でFirebaseをimportしておく

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //currentUserがnilならログインしていない
        if Auth.auth().currentUser == nil {
            //ログインしていない時の処理
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //タブアイコンの色
        self.tabBar.tintColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha:1)
        //タブバーの背景色
        self.tabBar.barTintColor = UIColor(red: 0.96, green:0.91, blue: 0.87, alpha:1)
        //UITabBarControllerDelegateプロトコルのメソッドでこのクラスを処理する
        self.delegate = self
    }
    
    //タブバーのアイコンがタップされた時に呼ばれるdelegateメソッドを処理する。
    func tabBarController(_ tabBarCOntroller: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is ImageSelectViewController {
            //ImageSelectViewControllerは、タブ切り替えでなくモーダル画面遷移する
            let imageSelectViewController = storyboard!.instantiateViewController(withIdentifier: "ImageSelect")
            present(imageSelectViewController, animated: true)
            return false
        } else {
            //その他のViewControllerは通常のタブ切り替えを実施
            return true
        }
    }

}
