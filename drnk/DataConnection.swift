

import Foundation
import Alamofire

class DataConnection {

    var post : NSArray!
    var typeOfBusiness : String!
    
    init(typeOfBusiness:String){
        
        self.typeOfBusiness = typeOfBusiness
        
    }
    
    func requestData(completionHandler: (responseObject: NSArray?, error: NSError?) -> ()){
      
        Alamofire.request(.GET, "http://drnkmobile.com/api/v1/businesses/" + typeOfBusiness+"/?zipcode="+currentUserZip + "&radius=10")
            .responseJSON {(request, response, json, error) in
                
                if json == nil{
                    
                    
                    self.post = nil
                    
                } else {
                    
                    self.post = json as! NSArray
                    
                }
                
                completionHandler(responseObject: self.post , error: error)
                
        }
        
    }
    
    func getData(completionHandler: (responseObject: NSArray?, error: NSError?) -> ()){
        
       requestData(completionHandler)
        
    }

}
    

