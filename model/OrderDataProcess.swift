//
//  OrderDataProcess.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/7/20.
// 訂單顯示、刪除資料

import Foundation

struct OrderDataProcessResponse:Codable {
    let records:[OrderDataProcess]
}
struct OrderDataProcess:Codable {
    let fields:DataProces
    let id:String
}
struct DataProces:Codable {
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
    let imageUrl:URL

}
