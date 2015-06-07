

import Foundation
import Alamofire
class DataConnection {
    
    
    func requestData(){
        Alamofire.request(.GET, "http://kramercorporation.com/my-rest-api/companies.php")
            .responseJSON {(request, response, JSON, error) in
                println(JSON)
        }
    }
    
}