//  po XCUIApplication() Получить DOM модель, ключи к моему UI. Для получения лоакторов. 
//  UITests.swift
//  UITests
//
//  Created by Егор Янкович on 3/17/21.
//

import XCTest

let app = XCUIApplication()

class PositiveTest: XCTestCase {
    
    override func setUp() {
        
//        continueAfterFailure = false
    
    }
    override func tearDown() {
    }
    
 // Entered a valid credentials
    func testLoginPage() {
        app.launch()
        sleep(1)
        app.textFields["userLogin"].tap()
        app.textFields["userLogin"].typeText("admin")
        sleep(1)
        app.textFields["userPassword"].tap()
        app.textFields["userPassword"].typeText("test")
       // app.buttons["Login"].tap()
        sleep(1)
        XCTAssertTrue(app.tabBars["Tab Bar"].exists, "Tab Bar doesn't exist")
        XCTAssertTrue(app.tables["imageTable"].exists, "Table doesn't exist")
        continueAfterFailure = false
    }
    
    func testAuto() {
                
    }
    
    // Tested reloading photos using low quolity
    func testLowQ()  {
       // testLoginPage()
        app.pickerWheels["low"].adjust(toPickerWheelValue: "smal")
        sleep(1)
        
        app.textFields["perPageLabelLabel"].tap()
        app.textFields["perPageLabelLabel"].clearAndEnterText(text: "10")
        sleep(1)
        app.textFields["pageLabel"].tap()
        app.textFields["pageLabel"].clearAndEnterText(text: "1")
        sleep(1)
        app.buttons["Reload"].tap()
    }
    
    // Tested reloading photos using medium quolity
    func testSmalQ()  {
        app.pickerWheels["large"].adjust(toPickerWheelValue: "med")
        sleep(1)
        app.textFields["perPageLabelLabel"].tap()
        app.textFields["perPageLabelLabel"].clearAndEnterText(text: "15")
        sleep(1)
        app.textFields["pageLabel"].tap()
        app.textFields["pageLabel"].clearAndEnterText(text: "2")
        sleep(1)
        app.buttons["Reload"].tap()
    }
    
    // Tested reloading photos using large quolity
    func testLrgQ()  {
        app.pickerWheels["smal"].adjust(toPickerWheelValue: "large")
        sleep(1)
        app.textFields["perPageLabelLabel"].tap()
        app.textFields["perPageLabelLabel"].clearAndEnterText(text: "15")
        sleep(1)
        app.textFields["pageLabel"].tap()
        app.textFields["pageLabel"].clearAndEnterText(text: "2")
        sleep(1)
        app.buttons["Reload"].tap()
    }
}

class NegativeTesting: XCTestCase {
    func testLoginPage() {
        
        var loginTitle: XCUIElement {
            return app.staticTexts["loginTitle"].firstMatch
        }
        
        var passwordTitle: XCUIElement {
            return app.staticTexts["passwordTitle"].firstMatch
        }
        
        app.launch()
        sleep(1)
        app.textFields["userLogin"].tap()
        app.textFields["userLogin"].typeText("admin123")
        sleep(1)
        app.textFields["userPassword"].tap()
        app.textFields["userPassword"].typeText("test123")
        app.buttons["Login"].tap()
        sleep(1)
        
        XCTAssertEqual(loginTitle.label, "Incorrect password or login")
        XCTAssertEqual(passwordTitle.label, "Try again")
        XCTAssertTrue(app.tabBars["Tab Bar"].exists == false, "Tab Bar exist")
    }
}

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
        self.typeText(text)
    }
}
