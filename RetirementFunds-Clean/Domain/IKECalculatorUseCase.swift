import Foundation

struct RetirementPlan {
    
    let annualSavingsAmount: Int
    let yearsToRetire: Int
    let rateOfReturn = 4
    
}

protocol IKECalculatorUseCaseProtocol {
    func computeFutureCapital(for plan: RetirementPlan) -> Int
}

final class IKECalculatorUseCase: IKECalculatorUseCaseProtocol {
    
    func computeFutureCapital(for plan: RetirementPlan) -> Int {
        let annualSavings = Decimal(plan.annualSavingsAmount)
        let rateOfReturn = 1 + Decimal(plan.rateOfReturn) / 100
        
        guard plan.yearsToRetire > 0 else {
            return plan.annualSavingsAmount
        }
        
        var totalCapital: Decimal = 0
        for _ in 0..<plan.yearsToRetire {
            totalCapital = (totalCapital + annualSavings) * rateOfReturn
        }
        
        return Int((totalCapital as NSDecimalNumber).doubleValue)
    }
    
}
