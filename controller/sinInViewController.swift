//
//  sinInViewController.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/6/22.
//
//登入畫面

import UIKit

class sinInViewController: UIViewController {
    //帳號輸入
    @IBOutlet weak var sinInEmailTextField: UITextField!
    //密碼輸入
    @IBOutlet weak var sinInPassWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //開始按鈕
    @IBAction func sinIn(_ sender: UIButton) {
    }
    //會員註冊按鈕
    @IBAction func joinEmail(_ sender: UIButton) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "\(joinViewController.self)"){
            controller.modalPresentationStyle = .fullScreen //變成全畫面模式
            present(controller, animated: true, completion: nil)
        }
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
