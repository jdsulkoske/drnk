

import Foundation
import Alamofire

class DataConnection {

    var post : NSArray!
    var error : ErrorType?
    var typeOfBusiness : String!
    
    init(typeOfBusiness:String){
        
        self.typeOfBusiness = typeOfBusiness
        
    }
    
    func requestData(completionHandler: (responseObject: NSArray?, error: ErrorType?) -> ()){
      
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
//        Alamofire.request(.GET, requestString)
//            .responseJSON { _, _, result in
//                switch result {
//                case .Success(let data):
//                    self.post = data as! NSArray
//                    debugPrint(self.post[1])
//                case .Failure(_, let error):
//                    self.error = error
//                    print("Request failed with error: \(error)")
//                
//                }
//                completionHandler(responseObject: self.post , error: self.error)
//
//        }
        Alamofire.request(.GET, requestString).responseJSON() {
            response in
            if response.result.isSuccess {
                let data = response.result.value
                    self.post = data as! NSArray
                    debugPrint(self.post[1])
                    
            } else {
                let error = self.error
                print("Request failed with error: \(error)")
            }
                completionHandler(responseObject: self.post , error: self.error)
        }
        
    }
    
    
    
    func getData(completionHandler: (responseObject: NSArray?, error: ErrorType?) -> ()){
        
       requestData(completionHandler)
        
    }

}
    

