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
        
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components((.CalendarUnitHour | .CalendarUnitMinute), fromDate: date)
        let thishour = comp.hour
        let minute = comp.minute
        
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
        
        var todayString = findDay(dayString)
        
        if hour() < 5 {
            
            return todayString - 1
            
        }
        
        return todayString
        
    }
    
    func intValueToDayString(intValueOfDay:Int) -> String{
        
        if intValueOfDay == 0 {
            
            return "Sunday"
            
        } else if intValueOfDay == 1{
            
            return "Monday"
            
        } else if intValueOfDay == 2 {
            
            return "Tuesday"
            
        } else if intValueOfDay == 3 {
            
            return "Wednesday"
            
        } else if intValueOfDay == 4 {
            
            return "Thursday"
            
        } else if intValueOfDay == 5 {
            
            return "Friday"
            
        } else if intValueOfDay == 6 {
            
            return "Saturday"
            
        } else if intValueOfDay == 7 {
            
            return "Sunday"
            
        } else {
            
            return "Something went wrong!"
            
        }
        
    }
    
    func getDayAsString()-> String{
        
        var intValue = getIntValueOfDay()
        
        return intValueToDayString(intValue)
        
    }
    
}
