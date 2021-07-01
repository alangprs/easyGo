//
//  personalDataTableViewController.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/6/30.
//基本資料修改

import UIKit
import Firebase

class personalDataTableViewController: UITableViewController {

    //0 姓名 1信箱
    @IBOutlet var editPersonal: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        upDataUI()
    }
    //取得使用者資訊
    func upDataUI(){
        if let user = Auth.auth().currentUser{
            editPersonal[0].text = user.displayName ?? ""
            
        }
    }
    
    //彈跳通知
    func textAlert(title:String,message:String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "確定", style: .default) { action in
            //跳回登入畫面
            if let goController = self.storyboard?.instantiateViewController(withIdentifier: "\(sinInViewController.self)"){
                goController.modalPresentationStyle = .fullScreen
                self.present(goController, animated: true, completion: nil)
            }
        }
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
        }
    //登出
    @IBAction func longUut(_ sender: UIButton) {
        if let _ = Auth.auth().currentUser{
            do {
                try Auth.auth().signOut()
                textAlert(title: "已登出", message: "等你回來")
                print("已登出")
            } catch {
                textAlert(title: "登出失敗", message: "\(error.localizedDescription)")
                print("登出失敗",error.localizedDescription)
            }
        }
    }
    
    //修改使用者資料
    @IBAction func edit(_ sender: Any) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = editPersonal[0].text
        //commitChanges 請求修改
                       changeRequest?.commitChanges(completion: { error in
                           guard error == nil else{
                               print(error?.localizedDescription)
                               return
                           }
                       })
    }
    
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
