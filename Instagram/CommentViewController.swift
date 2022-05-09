//
//  CommentViewController.swift
//  Instagram
//
//  Created by 濱上卓也 on 2022/05/07.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    
    
    var postData:PostData!
    
    var listener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("DEBUG_PRINT:\(postData.name!)")
    }
    
    @IBAction func commentButton(_ sender: Any) {
        if let commentText = textField.text{
            
            let comment:String
            
            //表示名が入力されていない時はHUDを出して何もしない
            if commentText.isEmpty{
                SVProgressHUD.showError(withStatus: "コメントを入力してください。")
                return
            }
            let user = Auth.auth().currentUser
            
            if postData.comment != nil {
                
                 comment = "\(postData.comment!) \n \(user!.displayName!) : \(commentText)"
            
            }else{
            
                comment = "コメント \n \(user!.displayName!) : \(commentText)"
            }
            //コメントを設定する
            print("DEBUG_PRINT:\(user!.displayName!) : \(commentText)")
            
       
            
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
          //  postRef.updateData(["comment":updateValue])
            postRef.updateData(["comment":comment])
            
            
            
            
            self.dismiss(animated: true, completion: nil)
      
        
        }
    
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
