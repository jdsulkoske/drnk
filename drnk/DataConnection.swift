

import Foundation
import Alamofire

class DataConnection {

    var post : NSArray!
    func requestData(completionHandler: (responseObject: NSArray?, error: NSError?) -> ()){
      
        Alamofire.request(.GET, "http://kramercorporation.com/my-rest-api/companies.php")
            .responseJSON {(request, response, json, error) in
              
                self.post = json as! NSArray
                  completionHandler(responseObject: self.post , error: error)
        }
    }
    func getData(completionHandler: (responseObject: NSArray?, error: NSError?) -> ()){
       requestData(completionHandler)
    }


}
    

