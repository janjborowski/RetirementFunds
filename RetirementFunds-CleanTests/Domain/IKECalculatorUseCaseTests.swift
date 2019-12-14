import XCTest
@testable import RetirementFunds_Clean

final class IKECalculatorUseCaseTests: XCTestCase {

    private let annualSavingsAmmount = 1000
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
        let plan = RetirementPlan(annualSavingsAmount: annualSavingsAmmount, yearsToRetire: 20)
        
        // Act
        let futureCapital = sut.computeFutureCapital(plan: plan)
        
        // Assert
        XCTAssertEqual(futureCapital, 30969)
    }
    
    func test_computeFutureCapital_shouldComputeCorrectValue_for5YearPeriod() {
        // Arrange
        let plan = RetirementPlan(annualSavingsAmount: annualSavingsAmmount, yearsToRetire: 5)
        
        // Act
        let futureCapital = sut.computeFutureCapital(plan: plan)
        
        // Assert
        XCTAssertEqual(futureCapital, 5632)
    }
    
    func test_computeFutureCapital_shouldComputeCorrectValue_for1YearPeriod() {
        // Arrange
        let plan = RetirementPlan(annualSavingsAmount: annualSavingsAmmount, yearsToRetire: 1)
        
        // Act
        let futureCapital = sut.computeFutureCapital(plan: plan)
        
        // Assert
        XCTAssertEqual(futureCapital, 1040)
    }
    
    func test_computeFutureCapital_shouldComputeCorrectValue_for0YearPeriod() {
        // Arrange
        let plan = RetirementPlan(annualSavingsAmount: annualSavingsAmmount, yearsToRetire: 0)
        
        // Act
        let futureCapital = sut.computeFutureCapital(plan: plan)
        
        // Assert
        XCTAssertEqual(futureCapital, 1000)
    }

}
