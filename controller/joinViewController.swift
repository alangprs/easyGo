//
//  joinViewController.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/6/23.
//註冊頁面

import UIKit
import Firebase

class joinViewController: UIViewController {
    //帳號輸入
    @IBOutlet weak var joinEmailTextField: UITextField!
    //密碼輸入
    @IBOutlet weak var joinPassWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    //彈跳通知
    func texAlert(title:String,message:String){
        let conrtoller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "確認", style: .default, handler: nil)
        conrtoller.addAction(action)
        present(conrtoller, animated: true, completion: nil)
    }
    //註冊功能
    func startJion(){
        Auth.auth().createUser(withEmail: self.joinEmailTextField.text!, password: self.joinPassWordTextField.text!) { result, error in
            //確認取得使用者資訊
            guard let _ = result?.user,
                  error == nil else {
                //註冊失敗執行
                if let error = error{
                    self.texAlert(title: "註冊失敗", message: "\(error.localizedDescription)")
                }
                
                print("印出註冊錯誤",error?.localizedDescription as Any)
                return
            }
            //註冊成功執行
            //            self.dismiss(animated: true, completion: nil)
            //跳轉到list頁面
            if let coneroller = self.storyboard?.instantiateViewController(withIdentifier: "ListNavigation"){
                coneroller.modalPresentationStyle = .fullScreen
                self.present(coneroller, animated: true, completion: nil)
            }
            print("註冊成功")
        }
    }
    //登入按鈕
    @IBAction func join(_ sender: Any) {
        startJion()
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
