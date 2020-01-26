import XCTest
@testable import RetirementFunds_Clean

final class IKZECalculatorUseCaseTests: XCTestCase {
    
    private var sut: IKZECalculatorUseCase!

    override func setUp() {
        super.setUp()
        
        sut = IKZECalculatorUseCase(financialConstants: .default)
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

    func test_computeFutureCapital_shouldReturnAnnualSavings_whenYearsToRetireIsZero() {
        // Arrange
        let plan = IKZESavingsPlan(annualSavings: 1000, yearsToRetire: 0, rateOfReturn: 10, taxBracket: 0.18, earlyExit: nil)
        
        // Act
        let result = sut.computeFutureCapital(for: plan)
        
        // Assert
        XCTAssertEqual(result.capital, plan.annualSavings)
        XCTAssertEqual(result.taxReturn, 0)
    }
    
    func test_computeFutureCapital_shouldReturnSavingsWithInterestAndTaxReturn_whenYearsToRetireIsGreaterThanZero() {
        // Arrange
        let plan = IKZESavingsPlan(annualSavings: 1000, yearsToRetire: 5, rateOfReturn: 5, taxBracket: 0.18, earlyExit: nil)
        
        // Act
        let result = sut.computeFutureCapital(for: plan)
        
        // Assert
        XCTAssertEqual(result.capital, 5221)
        XCTAssertEqual(result.taxReturn, 900)
    }
    
    func test_computeFutureCapital_shouldReturnCapital_whenEarlyExitTaxIsFlat() {
        // Arrange
        let plan = createSavingsPlan(
            with: .flatRate(0.19)
        )
        
        // Act
        let result = sut.computeFutureCapital(for: plan)
        
        // Assert
        XCTAssertEqual(result.capital, 4699)
        XCTAssertEqual(result.taxReturn, 900)
    }
    
    func test_computeFutureCapital_shouldReturnCapital_whenEarlyExitTaxIsProgressive_andLimitIsNotExceeded() {
        // Arrange
        let plan = createSavingsPlan(
            with: .progressiveRate(
                basicRate: 0.18,
                basicRateLimit: 85562,
                excessRate: 0.32,
                yearToDateIncome: 0
            )
        )
        
        // Act
        let result = sut.computeFutureCapital(for: plan)
        
        // Assert
        XCTAssertEqual(result.capital, 4757)
        XCTAssertEqual(result.taxReturn, 900)
    }
    
    func test_computeFutureCapital_shouldReturnCapital_whenEarlyExitTaxIsProgressive_andLimitIsPartiallyExceeded() {
        // Arrange
        let plan = createSavingsPlan(
            with: .progressiveRate(
                basicRate: 0.18,
                basicRateLimit: 85562,
                excessRate: 0.32,
                yearToDateIncome: 83000
            )
        )
        
        // Act
        let result = sut.computeFutureCapital(for: plan)
        
        // Assert
        XCTAssertEqual(result.capital, 4303)
        XCTAssertEqual(result.taxReturn, 900)
    }
    
    func test_computeFutureCapital_shouldReturnCapital_whenEarlyExitTaxIsProgressive_andLimitIsExceeded() {
        // Arrange
        let plan = createSavingsPlan(
            with: .progressiveRate(
                basicRate: 0.18,
                basicRateLimit: 85562,
                excessRate: 0.32,
                yearToDateIncome: 90000
            )
        )
        
        // Act
        let result = sut.computeFutureCapital(for: plan)
        
        // Assert
        XCTAssertEqual(result.capital, 3945)
        XCTAssertEqual(result.taxReturn, 900)
    }
    
    private func createSavingsPlan(with earlyExit: IKZEEarlyExitTax) -> IKZESavingsPlan {
        return IKZESavingsPlan(
            annualSavings: 1000,
            yearsToRetire: 5,
            rateOfReturn: 5,
            taxBracket: 0.18,
            earlyExit: earlyExit
        )
    }
    
}
