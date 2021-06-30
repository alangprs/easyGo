//
//  mainViewController.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/6/30.
//

import UIKit
import Firebase
class mainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fixSinIn()
        // Do any additional setup after loading the view.
    }
    //判斷目前是否有登入，如果有登入跳轉至list頁面
    func fixSinIn(){
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil{
                if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ListNavigation"){
                    controller.modalPresentationStyle = .fullScreen //跳轉到list頁面時為滿版
                    self.present(controller, animated: true, completion: nil)
                }
            }else{ //如果沒登入 跳到登入畫面
                if let controller = self.storyboard?.instantiateViewController(withIdentifier: "\(sinInViewController.self)"){
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true, completion: nil)
                }
            }
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
