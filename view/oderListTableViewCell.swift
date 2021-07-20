//
//  oderListTableViewCell.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/6/28.
//訂購清單顯示

import UIKit

class oderListTableViewCell: UITableViewCell {
    
    //行程名稱
    @IBOutlet weak var travelNameLable: UILabel!
    //訂購人名稱
    @IBOutlet weak var subscriberName: UILabel!
    //上車地點
    @IBOutlet weak var pickUpLocation: UILabel!
    //人數
    @IBOutlet weak var numberOfPeople: UILabel!
    //總金額
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var oderListCellImage: UIImageView!
    var oderListCellData:OrderDataProcess! //解析後的資料
    
    //cell 要顯示的資料
    func oderListCellView(){
        travelNameLable.text = "行程名稱：\(oderListCellData.fields.strokeName)"
        subscriberName.text = "訂購人姓名:\(oderListCellData.fields.name)"
        pickUpLocation.text = "上車地點:\(oderListCellData.fields.pickUpLocation)"
        numberOfPeople.text = "人數:\(oderListCellData.fields.numberOfPeople)"
        totalPrice.text = "總金額\(oderListCellData.fields.price)"
        //抓照片
        if let url = URL(string: "\(oderListCellData.fields.imageUrl)"){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data{
                    DispatchQueue.main.async {
                        self.oderListCellImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
