//
//  informationTableViewController.swift
//  
//
//  Created by 翁燮羽 on 2021/6/26.
//

import UIKit

class informationTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //選單數量
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //捲動內容的數量
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerViewItem.count
    }
    //選擇到選單資料後跑這段
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        enterInfo[5].text = pickerViewItem[row].rawValue
        enterInfo[5].resignFirstResponder()//收起pickerView
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewItem[row].rawValue
    }
   //上方view顯示資料
    //0 行程名稱 1人數 2日期 3總金額
    @IBOutlet var infoTripData: [UILabel]!
    //使用者輸入的資料textfild
    //0姓名 1電話 2身分證字號 3email 4出生日期 5上車地點
    @IBOutlet var enterInfo: [UITextField]!
    //送出按鈕 設定相關UI使用
    @IBOutlet weak var sendOutUI: UIButton!
    
    let datePicker = UIDatePicker() //日期選單
    let pickerView = UIPickerView() //地點選單
    //上車地點
    let pickerViewItem = [Location.新莊棒球場售票口對面,Location.三重爭鮮,Location.蘆洲區公所,Location.永平市場]
    
    var infoData:InfoData //接odery 資料
    init?(coder:NSCoder,infoData:InfoData) {
        self.infoData = infoData
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //製作一個可以裝datePicker的toolbar
    func createToolBar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(pressed))
        toolbar.setItems([barButtonItem], animated: true)
        return toolbar
    }
    //執行按下之後datePicker的顯示內容
        @objc func pressed(){
            let dateFormatter = DateFormatter() //日期樣式設定
            dateFormatter.dateStyle = .medium //文字顯示：中
            dateFormatter.dateFormat = "yyyy-MM-dd" //日期顯示方式 年、月、日
            //設定要使用的textFiled
            self.enterInfo[4].text = dateFormatter.string(from: datePicker.date)
            self.view.endEditing(true)
        }
    //組合datePicker 跟toolbar來使用
    func createDatePicker(){
            datePicker.preferredDatePickerStyle = .wheels //設定日期選擇樣式
            datePicker.datePickerMode = .date //只要日期
            datePicker.locale = Locale(identifier: "zh_TW") //設置語言環境：台灣
        enterInfo[4].inputView = datePicker //dateTextfield點下去時跳出datePicker選單
        enterInfo[4].inputAccessoryView = createToolBar() //執行工具
        }
    
    
    //畫面出現時一開始要顯示的內容
    func UpinfoDataView(){
        //顯示上一頁傳來行程資料
        infoTripData[0].text = infoData.strokeName
        infoTripData[1].text = "人數:\(infoData.peopleSanderValue)人"
        infoTripData[2].text = infoData.tirpDate
        infoTripData[3].text = "總金額:\(infoData.priceSum)元"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpinfoDataView()
        createDatePicker()//執行datePicker
        //pickerview 相關資料載入
        pickerView.delegate = self
        pickerView.dataSource = self
        enterInfo[5].inputView = pickerView //顯示pickerView
        self.sendOutUI.layer.cornerRadius = 15 //設定送出按鍵圓角
    }
    
    //資料上傳
    func upLoad(){
        // 要上傳的資料
        let upLoadData = UpLoadResponse(records: [UpLoadFields.init(fields: UpLoadData.init(name: enterInfo[0].text!, price: infoData.priceSum, tirpDate: infoData.tirpDate, phoneNumber: enterInfo[1].text!, strokeName: infoData.strokeName, Birthday: enterInfo[4].text!, IDNumber: enterInfo[2].text!, numberOfPeople: "\(infoData.peopleSanderValue)", Email: enterInfo[3].text!, pickUpLocation: enterInfo[5].text!))])
        
        let url = URL(string: "https://api.airtable.com/v0/app1piTZcAMGQEJA4/Table%201")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer keyyBKvryff4mC1qu", forHTTPHeaderField: "Authorization") //api Key
        //資料打包成data
        if let data = try? JSONEncoder().encode(upLoadData){
            request.httpBody = data
            URLSession.shared.dataTask(with: request) { data, respond, error in
                if let data = data{
                    let content = String(data:data,encoding: .utf8)
                                        print(content!)
                                        DispatchQueue.main.async {
                                            self.tableView.reloadData()
                                        }
                }else{
                    print("上傳資料失敗",error)
                }
            }.resume()
        }
    }
    //錯誤通知
    func textAlert(title:String,message:String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "確定", style: .default, handler: nil)
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
    }
    
    //送出按鈕
    @IBAction func sendOut(_ sender: UIButton) {
        if enterInfo[0].text != "",
           enterInfo[1].text != "",
           enterInfo[2].text != "",
           enterInfo[3].text != "",
           enterInfo[4].text != "",
           enterInfo[5].text != ""{
            upLoad()
            print("上傳")
        }else{
            textAlert(title: "上傳失敗", message: "請確認資料是否輸入完畢")
            print("失敗")
        }
     
    }
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
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
