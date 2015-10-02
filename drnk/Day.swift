//
//  Day.swift
//  drnk
//
//  Created by Jake Sulkoske on 6/10/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class Day: NSObject {
   
    var date = NSDate()
    
    var dayString : String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.stringFromDate(date)
        
        
    }
    func hour()-> Int{
        
//        let calendar = NSCalendar.currentCalendar()
        let calendar = NSCalendar.currentCalendar()
        let component = calendar.component(.Hour, fromDate:NSDate())
//        let comp = calendar.components((.CalendarUnitHour | .CalendarUnitMinute), fromDate: date)

        let thishour = component.hashValue
//        let minute = component.hashValue
        
        return thishour
        
    }
    
    enum Day : Int {
        
        case Funday = 0, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
        
    }
    func findDay(dayOfWeek: String) -> Int{
        
        switch dayOfWeek {
            
        case "Monday":
            
            return Day.Monday.rawValue
            
        case "Tuesday":
            
            return Day.Tuesday.rawValue
            
        case "Wednesday":
            
            return Day.Wednesday.rawValue
            
        case "Thursday":
            
            return Day.Thursday.rawValue
            
        case "Friday":
            
            return Day.Friday.rawValue
            
        case "Saturday":
            
            return Day.Saturday.rawValue
            
        case "Sunday":
            
            return Day.Sunday.rawValue
            
        default:
            
            return 14
            
        }
        
    }
    
    func getIntValueOfDay() -> Int {
        
        let todayString = findDay(dayString)
        
        if hour() < 5 {
            
            return todayString - 1
            
        }
        
        return todayString
        
    }
    
    func intValueToDayString(intValueOfDay:Int) -> String{
        
        switch intValueOfDay {
        case 0:
            
            return "Sunday"
        
        case 1:
            
            return "Monday"
        
        case 2:
            
            return "Tuesday"
        
        case 3:
            
            return "Wednesday"
            
        case 4:
            
            return "Thursday"
            
        case 5:
            
            return "Friday"
            
        case 6:
            
            return "Saturday"
            
        case 7:
            
            return "Sunday"
            
        default:
            
            return "Sunday"
        }
        
    }
    
    func getDayAsString()-> String{
        
        let intValue = getIntValueOfDay()
        
        return intValueToDayString(intValue)
        
    }
    
}
