import Foundation

extension Decimal {
    
    var intValue: Int {
        return Int((self as NSDecimalNumber).doubleValue)
    }
    
}
