

import Foundation
import Alamofire
import CoreData

class DataConnection {

    var post : NSArray!
    var error : ErrorType?
    var typeOfBusiness : String!
    var barsTrue : String!
    var liquorTrue : String!
    var currentCityForURL : String!
    let moc = DataController().managedObjectContext
    
    init(typeOfBusiness:String){
        
        self.typeOfBusiness = typeOfBusiness
        
    }
    
    func requestData(completionHandler: (responseObject: NSArray?, error: ErrorType?) -> ()){
        
//        var requestString = "http://drnkmedia.com/api/api.php/?company_city=muncie&" + typeOfBusiness
        let urlCity = fetch()
        var requestString = "http://drnkmedia.com/api/api.php/?company_city=" + urlCity + "&" + typeOfBusiness

        print(requestString)
        requestString = requestString.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        
        Alamofire.request(.GET, requestString).responseJSON() {
            response in
            if response.result.isSuccess {
                let data = response.result.value
                self.post = data as! NSArray
                    
            } else {
                let error = self.error
                print("Request failed with error: \(error)")
            }
                completionHandler(responseObject: self.post , error: self.error)
        }
        
    }
    
    func fetch() -> String{
    
        let cityFetch = NSFetchRequest(entityName: "Session")
        
        do {
            let fetchedCity = try moc.executeFetchRequest(cityFetch) as! [Session]
            currentCityForURL = "\(fetchedCity.last!.currentCity!)"
            
        } catch {
            fatalError("Bad things happened!")
        }
        
        return currentCityForURL
        
    }
    
    func getData(completionHandler: (responseObject: NSArray?, error: ErrorType?) -> ()){
        
       requestData(completionHandler)
        
    }

}
    

