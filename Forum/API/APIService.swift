//
//  APIService.swift
//  ChatGPT
//
//  Created by 陳逸煌 on 2023/2/8.
//

import Foundation

typealias HTTPHeaderField = [String: String]

typealias parameter = [String: Any]

typealias CompleteAction<T: JsonModel> = ((_ jsonModel: T?,_ error: Error?)->())

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}

enum HeaderField {
    
    case json
    
    var field: HTTPHeaderField {
        switch self {
        case .json:
            return [
                "Content-Type" : "application/json"
            ]
        }
    }
}


class APIService: NSObject {
    
    static let shared = APIService()
    
    private let apiQueue = DispatchQueue(label: "api_queue", qos: .utility)

    enum URLText: String {
        case regis = "http://www.yihuang.online/regis.php?"
        case login = "http://www.yihuang.online/login.php?"
        case getAllPost = "http://www.yihuang.online/getAllPost.php?"
        case addPost = "http://www.yihuang.online/addPost.php?"
        case getPersonalInfo = "http://www.yihuang.online/getPersonalInfo.php?"
        case getPersonalPost = "http://www.yihuang.online/getPersonalPost.php?"
    }
    //http://www.yihuang.online/regis.php?name=johnhhh&account=joh123456&password=1234&birthday=0850501
    //http://www.yihuang.online/login.php?account=joh123456&password=1234
        
    func requestWithParam<T: JsonModel>(httpMethod: HttpMethod = .post, headerField: HTTPHeaderField? = [:] , urlText: URLText, params: parameter, modelType: T.Type ,  completeAction: @escaping CompleteAction<T>) {
        
        var url = urlText.rawValue
        
        var paramText: [String] = []
        for param in params {
            paramText.append("\(param.key)=\(param.value)")
        }
        let paramTextUrl = paramText.joined(separator: "&")
        url = url + paramTextUrl
        
        if let text = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            url = text
        }
        
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            
            for header in headerField ?? [:] {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
            

            
            request.httpMethod = httpMethod.rawValue

            
            self.apiQueue.async {
                let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in

                    if let error = error {
                        completeAction(nil, error)
                    } else if let data = data {
                        do {
                            let json = try JBJson(data: data)
                            print(json)
                            completeAction(modelType.init(json: json), error)
                        } catch {
                            completeAction(nil, error)
                        }
                    }
                }

                task.resume()
            }
        }
    }
    
}


