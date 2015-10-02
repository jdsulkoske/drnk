

import Foundation
import Alamofire

class DataConnection {

    var post : NSArray!
    var typeOfBusiness : String!
    
    init(typeOfBusiness:String){
        
        self.typeOfBusiness = typeOfBusiness
        
    }
    
    func requestData(completionHandler: (responseObject: NSArray?, error: NSError?) -> ()){
      
        let requestString = "http://drnkmobile.com/api/v1/businesses/" + typeOfBusiness+"/?zipcode="+currentUserZip + "&radius=10"
        
//        Alamofire.request(.GET, requestString).responseJSON { (request, response, json) -> Void in
//            if json == nil{
//                
//                self.post = nil
//                
//            } else {
//                
//                self.post = json as! NSArray
//                
//            }
//            completionHandler(responseObject: self.post , error: error)
//        }
        Alamofire.request(.GET, requestString)
            .responseJSON { _, _, result in
                print(result)
        }
        
    }
    
    
    
    func getData(completionHandler: (responseObject: NSArray?, error: NSError?) -> ()){
        
       requestData(completionHandler)
        
    }

}
    

