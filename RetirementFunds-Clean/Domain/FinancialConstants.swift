import Foundation

struct FinancialConstants {
    
    struct TaxBracket {
    
        let value: Decimal
        let name: String
        
    }
    
    let basicRateOfReturn: Int
    let capitalGainsTax: Decimal
    let flatRateIncomeTax: Decimal
    let taxBrackets: [TaxBracket]
    
    static var `default`: FinancialConstants {
        return FinancialConstants(
            basicRateOfReturn: 4,
            capitalGainsTax: 0.19,
            flatRateIncomeTax: 0.1,
            taxBrackets: [
                .init(value: 0.17, name: "first_bracket".localized),
                .init(value: 0.32, name: "second_bracket".localized),
                .init(value: 0.19, name: "flat_tax".localized)
            ]
        )
    }
    
}
