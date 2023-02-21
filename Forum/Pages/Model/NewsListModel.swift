//
//  NewsListModel.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/16.
//

import Foundation

class NewsListModel: JsonModel {

    var success: Bool = false
    
    var message: String = ""
    
    var listModel: [NewsModel] = []
    
    required init(json: JBJson) {
        self.success = json["success"].booleanValue
        self.message = json["message"].stringValue
        self.listModel = json["list"].arrayValue.map({NewsModel(json: $0)})
    }

}

class NewsModel: JsonModel {
    
    var account: String?
    
    var name: String?
    
    var content: String?
    
    var date: String?
    
    init(){
        
    }
    
    required init(json: JBJson) {
        self.account = json["account"].stringValue
        self.name = json["name"].stringValue
        self.content = json["content"].stringValue
        self.date = json["date"].stringValue
    }
    
    convenience init(
        account: String?,
        name: String?,
        content: String?,
        date: String?
    ){
        self.init()
        self.name = name
        self.content = content
        self.date = date
    }
    
}
