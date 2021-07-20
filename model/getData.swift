//
//  getData.swift
//  easyGo
//
//  Created by 翁燮羽 on 2021/6/24.
//
//資料下載
import Foundation

struct GETResponse:Decodable {
    let records:[Records]
}
struct Records:Decodable {
    let fields:Fields
    
}
struct Fields:Decodable {
    let price:Int
    let tripDetel:String
    let name:String
    let tripDay:Int
    let image:URL
    let tirpDate:String
    let ltineraryContent:String
}
