//
//  sinInViewController.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/6/22.
//
//登入畫面

import UIKit
import Firebase

class sinInViewController: UIViewController {
    //帳號輸入
    @IBOutlet weak var sinInEmailTextField: UITextField!
    //密碼輸入
    @IBOutlet weak var sinInPassWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            guard let user = result?.user else {
                //登入失敗執行
                if let error = error{
                    self.texAlert(title: "登入失敗", message: "\(error.localizedDescription)")
                }
                print("登入失敗",error?.localizedDescription)
                return
            }
            //登入成功執行
            print("登入成功")
        }
    }
    //登出
    func sinOut(){
        do {
            try Auth.auth().signOut()
            texAlert(title: "已登出", message: "等你回來")
            print("已登出")
        } catch {
            texAlert(title: "登出失敗", message: "\(error.localizedDescription)")
            print("登出失敗",error.localizedDescription)
        }
    }
    
    
    //開始按鈕
    @IBAction func sinIn(_ sender: UIButton) {
        emailSinIn()
    }
    //會員註冊按鈕
    @IBAction func joinEmail(_ sender: UIButton) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "\(joinViewController.self)"){
            controller.modalPresentationStyle = .fullScreen //變成全畫面模式
            present(controller, animated: true, completion: nil)
        }
    }
    //登出
    @IBAction func sinOut(_ sender: Any) {
        sinOut()
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
