//
//  AlamofireRequest.swift
//  VOLTEX
//
//  Copyright © 2019 VOLTEX. All rights reserved.
//
import UIKit
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

class AlamofireRequest: NSObject {
    static let shared = AlamofireRequest()
    var alamoFireManager : SessionManager?
  
    
    
    
    func getDataFrom(urlString : String ,isLoader : Bool, loaderMessage : String, authToken : String? , completion: @escaping (_ success: AnyObject?,_ error : Error?) -> Void) {
        
        print(urlString)
        if Connectivity.isConnectedToInternet {
            
            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            //let appendedURL : String = AlamofireRequest.appBaseURL + urlString
            
            var headers: HTTPHeaders!
            if authToken != nil{
                let bearer : String = "Bearer \(authToken!)"
                headers = [
                    "Authorization": bearer,
                    "Accept": "application/json"
                ]
            }
            
            Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default , headers : headers )
                .responseJSON { response in
                    if isLoader{
                        Indicator.shared.stopAnimating()
                    }
                    if let responseDictionary = response.result.value{
                        completion(responseDictionary as AnyObject, nil)
                    }else{
                        completion(nil , response.error)
                    }
            }
        }
        else{
            let Alert = alert()
            Alert.msg(message: "Internet not available.", title: "Warning!")
        }
    }
    
    
    func postDataFor(urlString : String,parameters : Parameters? ,authToken : String?,imageData : Data?,isLoader : Bool, loaderMessage : String, completion: @escaping (_ success: [String : AnyObject]?,_ error : Error?) -> Void) {
        
        
        if Connectivity.isConnectedToInternet {

            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            let appendedURL : String =   urlString
            
            var headers: HTTPHeaders!
            if authToken != nil{
                let bearer : String = "Bearer \(authToken!)"
                headers = [
                    "Authorization": bearer,
                    "Accept": "application/json"
                ]
            }
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters ?? [:] {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                if imageData != nil{
                    multipartFormData.append(imageData!, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
                }
                
            }, usingThreshold: UInt64.init(), to: appendedURL, method: .post, headers: headers) { (result) in
                switch result{
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            
                            completion(responseDictionary as? [String : AnyObject] , nil)
                        }else{
                            completion(nil , response.error)
                        }
                    }
                case .failure( let error):
                    if isLoader{
                        Indicator.shared.stopAnimating()
                    }
                    print(error)
                    completion(nil , error)
                }
            }
        }
        else
            
        {
            let Alert = alert()
            Alert.msg(message: "Internet not available.", title: "Warning!")
        }
    }
    
    
    func postBodyFor(urlString : String,parameters : Parameters ,authToken : String?,isLoader : Bool, loaderMessage : String, completion: @escaping (_ success: [String : AnyObject]?,_ error : Error?) -> Void) {
        
        
        if Connectivity.isConnectedToInternet {

            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            let appendedURL : String =   urlString
            
            var headers: HTTPHeaders!
            if authToken != nil{
                let bearer : String = "Bearer \(authToken!)"
                headers = [
                    "Authorization": bearer,
                    "Accept": "application/json"
                ]
            }
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, usingThreshold: UInt64.init(), to: appendedURL, method: .post, headers: headers) { (result) in
                switch result{
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            
                            completion(responseDictionary as? [String : AnyObject] , nil)
                        }else{
                            completion(nil , response.error)
                        }
                    }
                case .failure( let error):
                    if isLoader{
                        Indicator.shared.stopAnimating()
                    }
                    print(error)
                    completion(nil , error)
                }
            }
        }
        else
            
        {
            let Alert = alert()
            Alert.msg(message: "Internet not available.", title: "Warning!")
        }
    }
    
    
    func putValueWith(urlString : String ,isLoader : Bool,param : Parameters? ,loaderMessage : String,auth: String?, completion: @escaping (_ success: [String : AnyObject]?,_ error : Error?) -> Void){
        
        var headers: HTTPHeaders!
        if auth != nil{
            let bearer : String = "Bearer \(auth!)"
            headers = [
                "Authorization": bearer,
                "Accept": "application/json"
            ]
        }
        if Connectivity.isConnectedToInternet {
            Alamofire.request(urlString, method: .put, parameters: param,encoding: URLEncoding.queryString, headers: headers).responseJSON {
                response in
                if isLoader == true{
                    Indicator.shared.stopAnimating()
                }
                switch response.result {
                case .success:
                    print(response)
                    
                    if let responseDictionary = response.result.value{
                        
                        completion(responseDictionary as? [String : AnyObject] , nil)
                    }else{
                        completion(nil , response.error)
                    }
                    
                    break
                case .failure(let error):
                    if isLoader{
                        Indicator.shared.stopAnimating()
                    }
                    print(error)
                    completion(nil , error)
                }
            }
        }
        else{
            let Alert = alert()
            Alert.msg(message: "Internet not available.", title: "Warning!")
        }
    }
    
    
    func getBodyFrom(urlString : String ,isLoader : Bool,param : Parameters? ,loaderMessage : String,auth: String?, completion: @escaping (_ success: AnyObject?,_ error : Error?) -> Void) {
        

        if Connectivity.isConnectedToInternet {

            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            //let appendedURL : String = AlamofireRequest.appBaseURL + urlString
            
            if let url = URL(string: urlString) {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTPMethod.get.rawValue
                
                let configuration = URLSessionConfiguration.default
                configuration.timeoutIntervalForRequest = 180
                alamoFireManager = Alamofire.SessionManager(configuration: configuration)

                
                if auth != nil{
                    
                    let bearer : String = "Bearer \(auth!)"
                    
                    urlRequest.addValue(bearer, forHTTPHeaderField: "Authorization")
                }
                
                
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

                
                Alamofire.request(urlRequest)
                    .responseJSON { response in
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            completion(responseDictionary as AnyObject, nil)
                        }else{
                            completion(nil , response.error)
                        }
                        
                        
                }
            }
        }
        else
            
        {
            let Alert = alert()
            Alert.msg(message: "Internet not available.", title: "Warning!")
        }
    }
    
    func getRequestWithAuth(auth: String? ,urlString : String ,isLoader : Bool,loaderMessage : String, completion: @escaping (_ success: AnyObject?,_ error : Error?) -> Void) {
        if Connectivity.isConnectedToInternet {
            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            if let url = URL(string: urlString) {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTPMethod.get.rawValue
                
                if auth != nil{
                    let bearer : String = "Bearer \(auth!)"
                    urlRequest.addValue(bearer, forHTTPHeaderField: "Authorization")
                    urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
                }
                let configuration = URLSessionConfiguration.default
                configuration.timeoutIntervalForRequest = 180
                alamoFireManager = Alamofire.SessionManager(configuration: configuration)

                
                Alamofire.request(urlRequest)
                    .responseJSON { response in
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            completion(responseDictionary as AnyObject, nil)
                        }else{
                            completion(nil , response.error)
                        }
                }
            }
        }
        else{
            let Alert = alert()
            Alert.msg(message: "Internet not available.", title: "Warning!")
        }
    }
    
    
    func getQueryWith(auth: String? ,param: [String : Any] ,urlString : String ,isLoader : Bool,loaderMessage : String, completion: @escaping (_ success: AnyObject?,_ error : Error?) -> Void) {
        if Connectivity.isConnectedToInternet {
            if isLoader == true{
                Indicator.shared.startAnimating(withMessage: "")
            }
            
            var headers: HTTPHeaders?
            if auth != nil{
                let bearer : String = "Bearer \(auth!)"
                headers = [
                    "Authorization": bearer,
                    "Content-Type": "application/json"
                ]
            }
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 180
            alamoFireManager = Alamofire.SessionManager(configuration: configuration)

            Alamofire.request(urlString, method: .get, parameters: param as Parameters,encoding: URLEncoding.queryString, headers: headers).responseJSON {
                response in
                if isLoader{
                    Indicator.shared.stopAnimating()
                }
                switch response.result {
                case .success:
                    if let responseDictionary = response.result.value{
                        print(responseDictionary)
                        completion(responseDictionary as AnyObject, nil)
                    }else{
                        completion(nil , response.error)
                    }
                    break
                case .failure(let error):
                    print(error)
                    completion(nil, error)
                }
            }
        }
        else{
            let Alert = alert()
            Alert.msg(message: "Internet not available.", title: "Warning!")
        }
    }
    
    
    
    func PostBodyFrom(urlString : String ,isLoader : Bool,param : Parameters? ,loaderMessage : String,auth: String?, completion: @escaping (_ success: AnyObject?,_ error : Error?) -> Void) {
        
        
        if Connectivity.isConnectedToInternet {

            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            
            if let url = URL(string: urlString) {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTPMethod.post.rawValue
                let configuration = URLSessionConfiguration.default
                configuration.timeoutIntervalForRequest = 180
                alamoFireManager = Alamofire.SessionManager(configuration: configuration)

                if auth != nil{
                    
                    let bearer : String = "Bearer \(auth!)"
                    
                    urlRequest.addValue(bearer, forHTTPHeaderField: "Authorization")
                    urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
                }
                
                
                
                
                Alamofire.request(urlRequest)
                    .responseJSON { response in
                        
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            completion(responseDictionary as AnyObject, nil)
                        }else{
                            completion(nil , response.error)
                        }
                        
                        
                }
            }
        }
        else
            
        {
            let Alert = alert()
            Alert.msg(message: "Internet not available.", title: "Warning!")
        }
    }
    
    func PUTBodyFrom(urlString : String ,isLoader : Bool,param : Parameters? ,loaderMessage : String,auth: String?, completion: @escaping (_ success: AnyObject?,_ error : Error?) -> Void) {
        
        
        
        if Connectivity.isConnectedToInternet {

            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            
            if let url = URL(string: urlString) {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTPMethod.put.rawValue
                let configuration = URLSessionConfiguration.default
                configuration.timeoutIntervalForRequest = 180
                alamoFireManager = Alamofire.SessionManager(configuration: configuration)

                if auth != nil{
                    
                    let bearer : String = "Bearer \(auth!)"
                    
                    urlRequest.addValue(bearer, forHTTPHeaderField: "Authorization")
                    urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
                }
                
                
                
                
                Alamofire.request(urlRequest)
                    .responseJSON { response in
                        
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            completion(responseDictionary as AnyObject, nil)
                        }else{
                            completion(nil , response.error)
                        }
                        
                        
                }
            }
        }
        else
            
        {
            let Alert = alert()
            Alert.msg(message: "Internet not available.", title: "Warning!")
        }
    }
    
    func DeleteBodyFrom(urlString : String ,isLoader : Bool,param : Parameters? ,loaderMessage : String,auth: String?, completion: @escaping (_ success: AnyObject?,_ error : Error?) -> Void) {
        
        
        
        if Connectivity.isConnectedToInternet {
            if isLoader{
                Indicator.shared.startAnimating(withMessage: loaderMessage)
            }
            
            
            if let url = URL(string: urlString) {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTPMethod.delete.rawValue

                if auth != nil{
                    
                    let bearer : String = "Bearer \(auth!)"
                    
                    urlRequest.addValue(bearer, forHTTPHeaderField: "Authorization")
                    urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
                }
                
                
                
                
                Alamofire.request(urlRequest)
                    .responseJSON { response in
                        
                        if isLoader{
                            Indicator.shared.stopAnimating()
                        }
                        if let responseDictionary = response.result.value{
                            completion(responseDictionary as AnyObject, nil)
                        }else{
                            completion(nil , response.error)
                        }
                        
                        
                }
            }
        }
            
        else
        {
            let Alert = alert()
            Alert.msg(message: "Internet not available.", title: "Warning!")
        }
        
    }
}

