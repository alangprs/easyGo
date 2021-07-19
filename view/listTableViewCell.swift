//
//  listTableViewCell.swift
//  
//
//  Created by 翁燮羽 on 2021/6/24.
// 自定義的cell

import UIKit

class listTableViewCell: UITableViewCell {

    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var listLable: UILabel!
    
    var cellData:Records!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //cell要顯示的內容
    func cellView(){
        //行程名稱顯示
        listLable.text = cellData.fields.name
        //顯示圖片
        let url = cellData.fields.image
        URLSession.shared.dataTask(with: url) { data, respond, error in
            if let data = data{
                DispatchQueue.main.async {
                    self.listImage.image = UIImage(data: data)
                }
            }
        }.resume()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
