//
//  oderListTableViewController.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/6/28.
// 訂購清單

import UIKit

class oderListTableViewController: UITableViewController {
    var oderListData = [UpLoadFields]() //存下載的資料
    
    //下載選購清單資料
    func downloadOderListData(){
        let url = URL(string: "https://api.airtable.com/v0/app1piTZcAMGQEJA4/Table%201")!
        var request = URLRequest(url: url)
        request.setValue("Bearer keyyBKvryff4mC1qu", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data{
                do {
                    let recordsResponse = try JSONDecoder().decode(UpLoadResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    self.oderListData = recordsResponse.records
                    print("下載資料",recordsResponse)
                } catch {
                    print("oderList資料下載失敗",error)
                }
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadOderListData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return oderListData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(oderListTableViewCell.self)", for: indexPath) as? oderListTableViewCell else{return UITableViewCell()}
        cell.oderListCellData = oderListData[indexPath.row]
        cell.oderListCellView()
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
