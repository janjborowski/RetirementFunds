import Foundation

extension NumberFormatter {
    
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencyCode = "PLN"
        formatter.numberStyle = .currency
        formatter.currencyGroupingSeparator = " "
        formatter.maximumFractionDigits = 0
        formatter.locale = .onlyLocale
        return formatter
    }()
    
    static let rateOfReturnFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.multiplier = 1
        return formatter
    }()
    
}
