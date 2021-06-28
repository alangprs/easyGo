//
//  oderListTableViewCell.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/6/28.
//

import UIKit

class oderListTableViewCell: UITableViewCell {

    //0行程名稱 1訂購人名稱 2上車地點 3人數 4價格
    @IBOutlet var oderListCellLabelView: [UILabel]!
    
    var oderListCellData:UpLoadFields! //解析後的資料
    
    //cell 要顯示的資料
    func oderListCellView(){
        oderListCellLabelView[0].text = "行程名稱：\(oderListCellData.fields.strokeName)"
        oderListCellLabelView[1].text = "訂購人姓名:\(oderListCellData.fields.name)"
        oderListCellLabelView[2].text = "上車地點:\(oderListCellData.fields.pickUpLocation)"
        oderListCellLabelView[3].text = "人數:\(oderListCellData.fields.numberOfPeople)"
        oderListCellLabelView[4].text = "總金額\(oderListCellData.fields.price)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
