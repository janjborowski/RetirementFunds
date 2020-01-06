import XCTest
@testable import RetirementFunds_Clean

final class IKZECalculatorUseCaseTests: XCTestCase {
    
    private var sut: IKZECalculatorUseCase!

    override func setUp() {
        super.setUp()
        
        sut = IKZECalculatorUseCase()
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

    func test_computeFutureCapital_shouldReturnAnnualSavings_whenYearsToRetireIsZero() {
        // Arrange
        let savings = IKZERetirementSavings(annualSavings: 1000, yearsToRetire: 0, rateOfReturn: 10, taxBracket: 0.18)
        
        // Act
        let result = sut.computeFutureCapital(for: savings)
        
        // Assert
        XCTAssertEqual(result.capital, savings.annualSavings)
        XCTAssertEqual(result.taxReturn, 0)
    }
    
    func test_computeFutureCapital_shouldReturnSavingsWithInterestAndTaxReturn_whenYearsToRetireIsGreaterThanZero() {
        // Arrange
        let savings = IKZERetirementSavings(annualSavings: 1000, yearsToRetire: 5, rateOfReturn: 5, taxBracket: 0.18)
        
        // Act
        let result = sut.computeFutureCapital(for: savings)
        
        // Assert
        XCTAssertEqual(result.capital, 5801)
        XCTAssertEqual(result.taxReturn, 900)
    }
    
}
