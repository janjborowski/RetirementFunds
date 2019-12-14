import XCTest
@testable import RetirementFunds_Clean

final class IKECalculatorUseCaseTests: XCTestCase {

    private let annualSavingsAmmount = 1000
    private let rateOfReturn = 4
    private var sut: IKECalculatorUseCase!
    
    override func setUp() {
        super.setUp()
        sut = IKECalculatorUseCase()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_computeFutureCapital_shouldComputeCorrectValue_for20YearPeriod() {
        // Arrange
        let plan = RetirementPlan(annualSavingsAmount: annualSavingsAmmount, yearsToRetire: 20, rateOfReturn: rateOfReturn)
        
        // Act
        let futureCapital = sut.computeFutureCapital(for: plan)
        
        // Assert
        XCTAssertEqual(futureCapital.beforeTaxation, 30969)
        XCTAssertEqual(futureCapital.afterTaxation, 28885)
    }
    
    func test_computeFutureCapital_shouldComputeCorrectValue_for5YearPeriod() {
        // Arrange
        let plan = RetirementPlan(annualSavingsAmount: annualSavingsAmmount, yearsToRetire: 5, rateOfReturn: rateOfReturn)
        
        // Act
        let futureCapital = sut.computeFutureCapital(for: plan)
        
        // Assert
        XCTAssertEqual(futureCapital.beforeTaxation, 5632)
        XCTAssertEqual(futureCapital.afterTaxation, 5512)
    }
    
    func test_computeFutureCapital_shouldComputeCorrectValue_for1YearPeriod() {
        // Arrange
        let plan = RetirementPlan(annualSavingsAmount: annualSavingsAmmount, yearsToRetire: 1, rateOfReturn: rateOfReturn)
        
        // Act
        let futureCapital = sut.computeFutureCapital(for: plan)
        
        // Assert
        XCTAssertEqual(futureCapital.beforeTaxation, 1040)
        XCTAssertEqual(futureCapital.afterTaxation, 1032)
    }
    
    func test_computeFutureCapital_shouldComputeCorrectValue_for0YearPeriod() {
        // Arrange
        let plan = RetirementPlan(annualSavingsAmount: annualSavingsAmmount, yearsToRetire: 0, rateOfReturn: rateOfReturn)
        
        // Act
        let futureCapital = sut.computeFutureCapital(for: plan)
        
        // Assert
        XCTAssertEqual(futureCapital.beforeTaxation, 1000)
        XCTAssertEqual(futureCapital.afterTaxation, 1000)
    }

}
