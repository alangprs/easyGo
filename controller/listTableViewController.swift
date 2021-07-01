//
//  listTableViewController.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/6/22.
//

import UIKit
import Firebase

class listTableViewController: UITableViewController {

    var getData = [Records]()
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false) //隱藏Navigation Bar item
        downloadData()
        
    }
    
//    //下拉更新
//    func useUpdata(){
//        let refreshControl = UIRefreshControl()
//        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow]
//        //顯示文字內容
//        refreshControl.attributedTitle = NSAttributedString(string: "正在更新中", attributes: attributes)
////        refreshControl.tintColor = UIColor.black
////        refreshControl.backgroundColor = UIColor.white
//        tableView.refreshControl = refreshControl
//        refreshControl.addTarget(self, action: #selector(downloadData), for: UIControl.Event.valueChanged)
//
//    }
    
    //資料下載
    func downloadData(){
        ActivityIndicator.isHidden = false
        let url = URL(string: "https://api.airtable.com/v0/appE2Je8GWZrBuVzA/Table%201")!
        var request = URLRequest(url:url)
        request.setValue("Bearer keyyBKvryff4mC1qu", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, responds, error in
            if let data = data{
                do {
                    let recordsResponse = try JSONDecoder().decode(GETResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.ActivityIndicator.isHidden = true
                    }
                    self.getData = recordsResponse.records
                    
                } catch {
                    print("解析失敗",error)
                }
            }
        }.resume()
        
    }
    //要傳的資料
    @IBSegueAction func passToOderTableView(_ coder: NSCoder) -> orderTableViewController? {
        if let item = tableView.indexPathForSelectedRow?.row{
            return orderTableViewController(coder: coder, oderData: getData[item])
            
        }else{
            return nil
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
    @IBAction func sinInOut(_ sender: Any) {
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
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return getData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(listTableViewCell.self)", for: indexPath) as? listTableViewCell else{return UITableViewCell()}
        cell.cellData = getData[indexPath.row]
        cell.cellView()

        return cell
    }
    

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
