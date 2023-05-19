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
        self.success = json["status"].booleanValue
        self.message = json["message"].stringValue
        self.listModel = json["list"].arrayValue.map({NewsModel(json: $0)})
    }

}

class NewsModel: JsonModel {
    
    var account: String?
        
    var content: String?
    
    var date: String?
    
    init(){
        
    }
    
    required init(json: JBJson) {
        self.account = json["account"].stringValue
        self.content = json["content"].stringValue
        self.date = json["date"].stringValue
    }
    
    convenience init(
        account: String?,
        content: String?,
        date: String?
    ){
        self.init()
        self.content = content
        self.date = date
    }
    
}
