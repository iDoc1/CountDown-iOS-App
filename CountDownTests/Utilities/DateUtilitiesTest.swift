//
//  DateUtilitiesTest.swift
//  CountDownTests
//
//  Created by Ian Docherty on 2/23/25.
//

import XCTest
@testable import CountDown

final class DateUtilitiesTests: XCTestCase {
    func testDateDiffString0()  {
        let result = dateDiffString(daysAgo: 0)
        XCTAssertEqual(result, "Today")
    }
    
    func testDateDiffString1()  {
        let result = dateDiffString(daysAgo: 1)
        XCTAssertEqual(result, "1 day ago")
    }
    
    func testDateDiffString2()  {
        let result = dateDiffString(daysAgo: 2)
        XCTAssertEqual(result, "2 days ago")
    }
    
    func testDateDiffString29()  {
        let result = dateDiffString(daysAgo: 29)
        XCTAssertEqual(result, "29 days ago")
    }
    
    func testDateDiffString30()  {
        let result = dateDiffString(daysAgo: 30)
        XCTAssertEqual(result, "1 month ago")
    }
    
    func testDateDiffString35()  {
        let result = dateDiffString(daysAgo: 35)
        XCTAssertEqual(result, "1 month ago")
    }
    
    func testDateDiffString59()  {
        let result = dateDiffString(daysAgo: 59)
        XCTAssertEqual(result, "1 month ago")
    }
    
    func testDateDiffString60()  {
        let result = dateDiffString(daysAgo: 60)
        XCTAssertEqual(result, "2 months ago")
    }
    
    func testDateDiffString145()  {
        let result = dateDiffString(daysAgo: 145)
        XCTAssertEqual(result, "4 months ago")
    }
    
    func testDateDiffString365()  {
        let result = dateDiffString(daysAgo: 365)
        XCTAssertEqual(result, "1 year ago")
    }
    
    func testDateDiffString366()  {
        let result = dateDiffString(daysAgo: 366)
        XCTAssertEqual(result, "1+ years ago")
    }
    
    func testDateDiffString400()  {
        let result = dateDiffString(daysAgo: 400)
        XCTAssertEqual(result, "1+ years ago")
    }
}
