//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by alexandre pouget on 24/02/2017.
//  Copyright © 2017 alexandre pouget. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFarenheitToCelsius(){
        let weather = Weather()
        XCTAssertEqual(weather.farenheitToCelsius(temperature: 32),0)
    }
    
    func testFormaterDate(){
        let weather = Weather()
        let time = NSDate(timeIntervalSince1970: 1488052800)
        XCTAssertEqual(weather.formatDate(date: time, format: "HH:mm"),"15:00")
    }
    
    func testStrucRow(){
        let row = Weather.Row(time: "20:00", temp: "34", icon: "cloud")
        XCTAssertEqual(row.time,"20:00")
        XCTAssertEqual(row.temp,"34")
        
        XCTAssertNotEqual(row.icon,"sun")
    }
    
}
