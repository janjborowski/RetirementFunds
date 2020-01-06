import XCTest
@testable import RetirementFunds_Clean

final class NumberFormatterTests: XCTestCase {
    
    func test_currencyFormatter_shouldBeCorrectlyConfigured() {
        // Act
        let formattedNumber = NumberFormatter.currencyFormatter.string(for: 12345)
        
        // Assert
        XCTAssertEqual(formattedNumber, "12 345 zł")
    }
    
    func test_rateOfReturnFormatter_shouldBeCorrectlyConfigured() {
        // Act
        let formattedNumber = NumberFormatter.rateOfReturnFormatter.string(for: 11)
        
        // Assert
        XCTAssertEqual(formattedNumber, "11%")
    }

}
