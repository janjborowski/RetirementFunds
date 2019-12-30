import XCTest
@testable import RetirementFunds_Clean

final class IKECalculatorPresenterTests: XCTestCase {
    
    private final class IKECalculatorViewControllerMock: IKECalculatorViewControllerProtocol {
        
        var savedCurrentFormatter: Formatter?
        var savedRateOfReturnFormatter: Formatter?
        
        func loadFormatters(currencyFormatter: Formatter, rateOfReturnFormatter: Formatter) {
            self.savedCurrentFormatter = currencyFormatter
            self.savedRateOfReturnFormatter = rateOfReturnFormatter
        }
        
        func show(futureCapital: Int) {}
        
    }
    
    private var sut: IKECalculatorPresenter!
    private var viewControllerMock: IKECalculatorViewControllerMock!
    
    override func setUp() {
        super.setUp()
        
        sut = IKECalculatorPresenter()
        viewControllerMock = IKECalculatorViewControllerMock()
        sut.viewController = viewControllerMock
    }
    
    override func tearDown() {
        sut = nil
        viewControllerMock = nil
        
        super.tearDown()
    }
    
    func test_setUpPresenting_shouldReturnCorrectCurrencyFormatter() {
        // Act
        sut.setUpPresenting()
        
        // Assert
        let formattedNumber = viewControllerMock.savedCurrentFormatter?.string(for: 12345)
        XCTAssertEqual(formattedNumber, "12 345 zł")
    }
    
    func test_setUpPresenting_shouldReturnCorrectRateOfReturnFormatter() {
        // Act
        sut.setUpPresenting()
        
        // Assert
        let formattedNumber = viewControllerMock.savedRateOfReturnFormatter?.string(for: 11)
        XCTAssertEqual(formattedNumber, "11%")
    }

}
