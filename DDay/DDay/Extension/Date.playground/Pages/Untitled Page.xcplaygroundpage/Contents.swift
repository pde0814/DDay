
import UIKit

let worldCup2002Date = Date(year: 2002, month: 5, day: 31)

Date.today.days(from: worldCup2002Date)

Date.today

// -------------------------

// 구조체 날짜 타입
Date()
Date.now

// 클래스 날짜 타입
NSDate()
NSDate.now

// 달력 타입
// Calendar
// NSCalendar

// Timezone
// TimeZone
// NSTimeZone

let nsdate = Date.now as NSDate
// Toll-free briged Type

let now = Date()
print(now)
// 콘솔에서는 항상 UTC 시간으로 출력한다.

// 날짜 타입 내부에는 기준 날짜로부터 몇 초가 지났는지!
// 기준날짜 : Reference Date / Apple Epoch / Cocoa Epoch
// 2001-01-01 00:00:00

var dt = Date(timeIntervalSinceReferenceDate: 60 * 60)
print(dt)

dt = Date(timeIntervalSinceReferenceDate:  60 * 60 * -1)
print(dt)

// 날짜와 시간 처리의 기본 단위는 TimeInterval(1초)

let oneMillisecond = TimeInterval(0.001)

// 1분
let oneMinute = TimeInterval(60)

// 한시간
let oneHour = TimeInterval(oneMinute * 60)

// 하루
let oneDay = oneHour * 24

// 일주일
let oneWeek = oneDay * 7

// 현 시점부터 24시간 후의 시간
//let after24h = Date() + oneDay
let after24h = Date(timeIntervalSinceNow: oneDay)

// 특정날짜 기준
//Date(timeInterval: <#T##TimeInterval#>, since: <#T##Date#>)

// Unix와
//Date(timeIntervalSince1970: <#T##TimeInterval#>)
// 1970-01-01 00:00:00 Unix Epoch 유닉스의 기준 날짜

// 달력
// 양력, 음력, 히브리역
Calendar.Identifier.gregorian

Calendar.current // 변경 추적 x
Calendar.autoupdatingCurrent // 변경 추적 o

// 날짜 계산/조작하려면 항상 Calendar가 필요하다.
// NSCalendar



// DateComponents
// 컴포넌트 : 날짜와 시간을 구성하는 개별 요소 ex) 년, 월, 일, 시, 분, 초
// DateComponents
// NSDateComponents
let calendar = Calendar.current
var comps = calendar.dateComponents([.year, .month, .day], from: now)

comps.year
comps.month
comps.day

calendar.component(.year, from: now)


// 날짜 계산

// 오늘 기준으로 +100
let today = calendar.startOfDay(for: .now)

var day100comps = DateComponents()
day100comps.day = 100

calendar.date(byAdding: day100comps, to: today)

// 규칙을 정해야함
// 시간 포함? 안포함?
// 오늘을 포함? 안포함?
// 마지막 날짜를 어떻게 처리

// Date Formatter
// Step 1
let formatter = DateFormatter()

// Step 2
//formatter.dateStyle = .full
//formatter.timeStyle = .medium
//formatter.locale = Locale(identifier: "ko_kr")

// https://simplelocalize.io/data/locales/
// https://www.nsdateformatter.com/
//formatter.dateFormat = "M월 d일 (E)"

// Step 3
var result = formatter.string(from: .now)
//formatter.string(from: <#T##Date#>)
//formatter.string(for: <#T##Any?#>) 값이 안나오는 경우가 있음
print(result)

formatter.locale = Locale(identifier: "en_us")
formatter.setLocalizedDateFormatFromTemplate("yyyyMMMMdE")
print(formatter.dateFormat)
result = formatter.string(from: .now)

formatter.locale = Locale(identifier: "ko_kr")
formatter.setLocalizedDateFormatFromTemplate("yyyyMMMMdE")
print(formatter.dateFormat)
result = formatter.string(from: .now)


let yesterday = now.addingTimeInterval(3600 * -24)
//let yesterday = now.addingTimeInterval(3600 * -240)

let tomorrow = now.addingTimeInterval(3600 * 24)

formatter.locale = Locale(identifier: "ko_KR")
formatter.dateStyle = .full
formatter.timeStyle = .none
formatter.doesRelativeDateFormatting = true


print(formatter.string(from: now))
print(formatter.string(from: yesterday))
print(formatter.string(from: tomorrow))


// -----------------------
let weekdaySymbols = ["☀️", "🌕", "🔥", "💧", "🌲", "🥇", "🌏"]
let am = "🌅"
let pm = "🌇"

formatter.doesRelativeDateFormatting = false
formatter.dateStyle = .full
formatter.timeStyle = .full

formatter.amSymbol = am
formatter.pmSymbol = pm
formatter.weekdaySymbols = weekdaySymbols

print(formatter.string(from: now))
print(formatter.string(from: yesterday))
print(formatter.string(from: tomorrow))

// ---------------

let str = "2017-09-02T09:30:00Z"

formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

if let date = formatter.date(from: str) {
   formatter.dateStyle = .full
   formatter.timeStyle = .full

   print(formatter.string(from: date))
} else {
   print("invalid format")
}


// 범위 포맷팅
// 안쓰는 방식 / 플랜 b
let startDate = Date()
let endDate = startDate.addingTimeInterval(3600 * 24 * 30)

formatter.locale = Locale(identifier: "ko_KR")
formatter.dateStyle = .long
formatter.timeStyle = .short

print("\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))")


let intervalFomatter = DateIntervalFormatter()
intervalFomatter.locale = Locale(identifier: "ko_KR")
//intervalFomatter.dateStyle = .long
//intervalFomatter.timeStyle = .short
intervalFomatter.dateTemplate = "yyyyMMMdE"


print(intervalFomatter.string(from: startDate, to: endDate))


// 컴포넌트 포멧팅
let componentsFormatter = DateComponentsFormatter()
componentsFormatter.unitsStyle = .full
componentsFormatter.calendar?.locale = Locale(identifier: "ko_kr")


if let result = componentsFormatter.string(from: startDate, to: endDate) {
    print(result)
}

comps = DateComponents()

comps.hour = 1
comps.minute = 30
comps.second = 12

componentsFormatter.unitsStyle = .positional
componentsFormatter.zeroFormattingBehavior = .pad
componentsFormatter.string(from: comps)

comps.hour = 1
comps.minute = 30
componentsFormatter.maximumUnitCount = 1 // 유닛카운트가 부족하면 작은값부터 사라지고 반올림

componentsFormatter.string(from: comps)

componentsFormatter.allowedUnits = [.minute]

componentsFormatter.string(from: comps)

componentsFormatter.includesApproximationPhrase = true
componentsFormatter.includesApproximationPhrase = true
componentsFormatter.string(from: comps)




