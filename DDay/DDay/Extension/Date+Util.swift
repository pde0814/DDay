//
//  Date+Util.swift
//  DDay
//
//  Created by 박동언 on 5/27/25.
//

import Foundation

extension Date {
    init(year: Int, month: Int, day: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) {
        let calendar = Calendar.current
        let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)

        self = calendar.date(from: components) ?? .now
    }

    func days(from date: Date) -> Int? {
        let calendar = Calendar.current
        let from = calendar.startOfDay(for: date) // xxxx년 x월 x일 0시 0분 0초
        let to = calendar.startOfDay(for: self)

//        return calendar.dateComponents([.day], from: from, to: to).day ?? 0
        return calendar.dateComponents([.day], from: from, to: to).day
    }

    static var today: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: .now)
    }

    var upcomingBirthDay: Date {
        let calendar = Calendar.current // 1
        let thisYear = calendar.component(.year, from: Self.today) // 2

        var compos = calendar.dateComponents([.month, .day], from: self) // 3
        compos.year = thisYear // 4

        let date = calendar.date(from: compos) // 5

        if let date, date < Self.today { // 6
            compos.year = thisYear + 1 // 7

            return calendar.date(from: compos) ?? self // 8
        } else { // 9
            return date ?? self
        }
    }
}


