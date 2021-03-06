//
//  sinInViewController.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/6/22.
//
//登入畫面

import UIKit
import Firebase
import FacebookLogin

class sinInViewController: UIViewController {
    //帳號輸入
    @IBOutlet weak var sinInEmailTextField: UITextField!
    //密碼輸入
    @IBOutlet weak var sinInPassWordTextField: UITextField!
    
    @IBOutlet weak var fbSinInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //彈跳出通知
    func texAlert(title:String,message:String){
        let conertller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "確定", style: .default, handler: nil)
        conertller.addAction(action)
        present(conertller, animated: true, completion: nil)
    }
    //mail 登入
    func emailSinIn(){
        Auth.auth().signIn(withEmail: sinInEmailTextField.text!, password: sinInPassWordTextField.text!) { result, error in
            guard (result?.user) != nil else {
                //登入失敗執行
                if let error = error{
                    self.texAlert(title: "登入失敗", message: "\(error.localizedDescription)")
                }
                print("登入失敗",error?.localizedDescription as Any)
                return
            }
            //登入成功執行
            print("登入成功")
            self.getProvider()
            //跳下一頁
            if let coneroller = self.storyboard?.instantiateViewController(withIdentifier: "ListNavigation"){
                coneroller.modalPresentationStyle = .fullScreen
                self.present(coneroller, animated: true, completion: nil)
            }
            //清空帳號密碼
            self.sinInEmailTextField.text = ""
            self.sinInPassWordTextField.text = ""
        }
    }
    //fb
    func logIn(permissions: [Permission] = [.publicProfile],
               viewController: UIViewController? = nil,
               completion: LoginResultBlock? = nil){
    }
    //取得使用者資訊
    func getProvider(){
        if let user = Auth.auth().currentUser{
            if user.providerID.count > 0{
                _ = user.providerData[0]
                //判斷如果已經登入，直接跳到list頁面
                if let controller = storyboard?.instantiateViewController(withIdentifier: "ListNavigation"){
                    controller.modalPresentationStyle = .fullScreen
                    present(controller, animated: true, completion: nil)
                }
            }else{
                print("取得使用者資訊失敗")
            }
        }
    }
    //fb登入
    func fbLogIn(){
        
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: self) { (result) in
            if case LoginResult.success(granted: _, declined: _, token: _) = result {
                print("fb login ok")
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                Auth.auth().signIn(with: credential) { [weak self] (result, error) in
                    guard let self = self else {return}
                    guard error == nil else {
                        print("ＦＢ登入錯誤",error?.localizedDescription as Any)
                        return
                    }
                    print("firebase登入成功")
                    //取得使用者資訊
                    self.getProvider()
                    //判斷如果已經登入，直接跳到list頁面
                    if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ListNavigation"){
                        controller.modalPresentationStyle = .fullScreen
                        self.present(controller, animated: true, completion: nil)
                    }
                    
                }
            }else{
                print("firebase登入失敗")
            }
        }
    }
    
    //FB登入
    @IBAction func fbSinIn(_ sender: UIButton) {
        fbLogIn()
        
    }
    //開始按鈕
    @IBAction func sinIn(_ sender: UIButton) {
        emailSinIn()
        
    }
    //會員註冊按鈕
    @IBAction func joinEmail(_ sender: UIButton) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "\(joinViewController.self)"){
            present(controller, animated: true, completion: nil)
        }
    }
    
    
}
