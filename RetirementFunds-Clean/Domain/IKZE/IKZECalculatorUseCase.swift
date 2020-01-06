import Foundation

protocol IKZECalculatorUseCaseProtocol {
    func computeFutureCapital(for savings: IKZERetirementSavings) -> IKZEResult
}

final class IKZECalculatorUseCase: IKZECalculatorUseCaseProtocol {
    
    func computeFutureCapital(for savings: IKZERetirementSavings) -> IKZEResult {
        let annualSavings = Decimal(savings.annualSavings)
        
        guard savings.yearsToRetire > 0 else {
            return .init(noGainsCapital: savings.annualSavings)
        }
        
        var totalCapital: Decimal = 0
        let taxReturn: Decimal = annualSavings * savings.taxBracket * Decimal(savings.yearsToRetire)
        let capitalGrowth = 1 + Decimal(savings.rateOfReturn) / 100
        
        for _ in 0..<savings.yearsToRetire {
            totalCapital = (totalCapital + annualSavings) * capitalGrowth
        }
        
        return IKZEResult(capital: totalCapital, taxReturn: taxReturn)
    }
    
}
