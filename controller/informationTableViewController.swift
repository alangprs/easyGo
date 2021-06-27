//
//  informationTableViewController.swift
//  
//
//  Created by 翁燮羽 on 2021/6/26.
//

import UIKit

class informationTableViewController: UITableViewController {

   //上方view顯示資料
    //0 行程名稱 1人數 2日期 3總金額
    @IBOutlet var infoTripData: [UILabel]!
    //使用者輸入的資料textfild
    //0姓名 1電話 2身分證字號 3email 4出生日期 5上車地點
    @IBOutlet var enterInfo: [UITextField]!
    let datePicker = UIDatePicker() //日期選單
    
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
    //製造容納pickView的toolbar
    func pickerViewToolbar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(pressedPickerView))
        toolbar.setItems([barButtonItem], animated: true)
        return toolbar
    }
    @objc func pressedPickerView(){
        let pickerView = UIPickerView()
        
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
