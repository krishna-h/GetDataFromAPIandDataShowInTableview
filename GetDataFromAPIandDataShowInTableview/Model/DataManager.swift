//
//  DataManager.swift
//  JSonServerCommunicatin in Swift
//
//  Created by Mac on 11/07/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.
//

import Foundation
import UIKit

class DataManager: NSObject {
    
   static var shared = DataManager()

    var URLReqObj:URLRequest!
    var dataTaskObj:URLSessionDataTask!
    
    override init() {
        super.init()
    }

func taskDetails(type:String)->[String:Any]
{
   //creating dataoutput variable
   var convertedData:[String:Any]!
 
    //requesting to server by URLReqObj
   var URLReqObj = URLRequest(url: URL(string: type)!)
            URLReqObj.httpMethod = "GET"
            
            dataTaskObj = URLSession.shared.dataTask(with: URLReqObj, completionHandler: { (dataWeGot, connDetails, err) in
                
                    do {
                        convertedData = try JSONSerialization.jsonObject(with: dataWeGot!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                        
                    }catch{
                        print("Some thing went worng")
                    }
            })
            dataTaskObj.resume()
            
            while (convertedData == nil) {
                
            }
            return convertedData
        }
    }



