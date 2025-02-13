//
//  Model.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/20/24.
//

import Foundation
import SwiftData

@Model
final class UserInfo{
    @Attribute(.unique) var id:UUID
    var scheduleTime:String
    
    @Relationship(deleteRule: .cascade,inverse:\PeriodPill.userInfo)
    var curPill:PeriodPill?
    
    var historyPill:[PeriodPill] = [PeriodPill]()
    var isAlarm:Bool
    var isSiri:Bool
    
    var periodPill:PeriodPill?
    
    init(scheduleTime: String, curPill: PeriodPill? = nil) {
        self.id = UUID()
        self.scheduleTime = scheduleTime
        self.curPill = curPill
        self.historyPill = []
        self.isAlarm = false
        self.isSiri = false
        
    }
}

@Model
final class PeriodPill{
    //    @Attribute(.unique) let id:UUID
    var pillInfo:PillInfo
    @Attribute(.unique) var startIntake:String
    var finishIntake:String?
    @Relationship(deleteRule: .cascade,inverse:\DayData.periodPill)
    var intakeCal = [DayData]()
    var missDay:Int
    
    var userInfo:UserInfo?
    
    init(pillInfo: PillInfo, startIntake: String) {
        
        self.pillInfo = pillInfo
        self.startIntake = startIntake
        self.missDay = 0
        self.finishIntake = nil
        //        print(self.intakeCal) []
    }
    
    
}

@Model
final class DayData{
    @Attribute(.unique) let num:Int
    var status:Int
    var time:String?
    var sideEffect:[Bool]
    var memo:String
    var isRecord:Bool //기록한건 초기화 못하게
    
    
    
    var periodPill:PeriodPill?
    
    init(num:Int,periodPill:PeriodPill? = nil) {
        self.num = num
        self.status = 0
        self.sideEffect = [false,false,false]
        self.memo = ""
        self.time = nil
        self.periodPill = periodPill
        isRecord = false
    }
    
    
}

@Model
final class PillInfo{
    //    @Attribute(.unique) let id:UUID
    @Attribute(.unique) var pillName:String
    var intakeDay:Int
    var placeboDay:Int
    var wholeDay:Int
    var descriptionInfo:String?
    var type:String?
    
    init(pillName: String, intakeDay: Int, placeboDay: Int) {
        //        self.id = UUID()
        self.pillName = pillName
        self.intakeDay = intakeDay
        self.placeboDay = placeboDay
        self.wholeDay = intakeDay+placeboDay
        self.descriptionInfo = nil
        self.type = nil
    }
}
extension PeriodPill{
    func printAllDetails() {
        print("Period Pill Details:")
        print("ID: \(id)")
        print("Start Intake: \(startIntake)")
        if let finish = finishIntake {
            print("Finish Intake: \(finish)")
        } else {
            print("Finish Intake: None")
        }
        print("Miss Day: \(missDay)")
        print("Pill Info:")
        pillInfo.printAllDetails()
        print("Intake Calendar:")
        for dayData in intakeCal {
            dayData.printAllDetails()
        }
        //            if let user = userInfo {
        //                print("User Info:")
        //                user.printAllDetails()
        //            } else {
        //                print("User Info: None")
        //            }
    }
    func addDayDataEntries(count: Int,dayData:DayData) {
        for _ in 0..<count {
            self.intakeCal.append(dayData)
        }
    }
}

extension DayData{
    func printAllDetails() {
        print("Day Data Details:")
        print("num: \(num)")
        print("Status: \(status)")
        if let time = time {
            print("Time: \(time)")
        } else {
            print("Time: None")
        }
        print("Side Effects: \(sideEffect)")
        print("Memo: \(memo)")
    }
}
extension PillInfo {
    func printAllDetails() {
        print("Pill Info Details:")
        print("ID: \(id)")
        print("Pill Name: \(pillName)")
        print("Intake Day: \(intakeDay)")
        print("Placebo Day: \(placeboDay)")
        print("Whole Day: \(wholeDay)")
        if let description = descriptionInfo {
            print("Description: \(description)")
        } else {
            print("Description: None")
        }
        if let pillType = type {
            print("Type: \(pillType)")
        } else {
            print("Type: None")
        }
    }
}
