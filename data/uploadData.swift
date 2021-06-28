//
//  uploadData.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/6/27.
//上傳要用資料 下載顯示
//使用codable方便 解碼、包裝

import Foundation

struct UpLoadResponse:Codable {
    let records:[UpLoadFields]
}
struct UpLoadFields:Codable {
    let fields:UpLoadData
}
struct UpLoadData:Codable {
    let name:String
    let price:Int
    let tirpDate:String
    let phoneNumber:String
    let strokeName:String
    let Birthday:String
    let IDNumber:String
    let numberOfPeople:String
    let Email:String
    let pickUpLocation:String

}
