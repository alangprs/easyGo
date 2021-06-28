//
//  orderTableViewController.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/6/22.
//

import UIKit

class orderTableViewController: UITableViewController {

    
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var oderTirpDate: UILabel!
    @IBOutlet weak var oderTripName: UILabel!
    @IBOutlet weak var oderLtineraryContent: UILabel!
    @IBOutlet weak var oderTripDetel: UITextView!
    @IBOutlet weak var oderPrice: UILabel!
    @IBOutlet weak var peopleNumber: UILabel! //顯示人數
    @IBOutlet weak var personPrice: UILabel!//每人價格 讀每個行程的價格不用動
    
    @IBOutlet weak var totlePrice: UILabel!//總金額 人數＊價格
    
    var peopleSanderValue = 1 //存人數
    var priceSum = 0 //存計算後總金額
    //讀上一頁來的資料
    let oderData:Records
    
    init?(coder:NSCoder,oderData:Records){
        self.oderData = oderData
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //顯示抓到的資料
    func showOderDataView(){
        //顯示照片
        if let url = URL(string: "\(oderData.fields.image)"){
            URLSession.shared.dataTask(with: url) { data, respond, error in
                if let data = data{
                    DispatchQueue.main.async {
                        self.orderImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        //顯示其他資訊
        oderTirpDate.text = oderData.fields.tirpDate
        oderTripName.text = oderData.fields.name
        oderLtineraryContent.text = oderData.fields.ltineraryContent
        oderPrice.text = "$\(oderData.fields.price)/人"
        oderTripDetel.text = oderData.fields.tripDetel
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showOderDataView()
        personPrice.text = "每人\(oderData.fields.price)元" //顯示讀到的單人金額
        totlePrice.text = "總金額：\(oderData.fields.price)元" //顯示總金額
    }
    
    //alert通知
    func confirmAlert(){
        let controller = UIAlertController(title: "是否送出訂單？", message:"行程名稱:\(oderData.fields.name) \n 人數:\(peopleSanderValue) \n 行程日期:\(oderData.fields.tirpDate) \n總金額:\(priceSum)" , preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "確認", style: .default) { _ in
            print("跳下一頁")
        }
        let noAction = UIAlertAction(title: "取消", style: .default, handler: nil)
        controller.addAction(yesAction)
        controller.addAction(noAction)
        present(controller, animated: true, completion: nil)
    }
    
    //人數選擇
    @IBAction func peopleStepper(_ sender: UIStepper) {
        peopleSanderValue = Int(sender.value)
        peopleNumber.text = "\(peopleSanderValue)" //顯示目前選擇人數
        priceSum = oderData.fields.price * peopleSanderValue //計算總金額
        totlePrice.text = "總金額：\(priceSum)元" //顯示總金額
    }

    //傳資料到info頁面
    @IBSegueAction func toInfo(_ coder: NSCoder) -> informationTableViewController? {
        //新增總資料到要傳的自定義info型別裡
        let toInfoData = InfoData(strokeName: oderData.fields.name, peopleSanderValue: peopleSanderValue, priceSum: priceSum, tirpDate: oderData.fields.tirpDate, imageUrl: oderData.fields.image)
        return informationTableViewController(coder: coder, infoData: toInfoData)
    }

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
