import Foundation

protocol IKECalculatorPresenterProtocol {
    func setUpPresenting()
    func show(futureCapital: Int)
}

final class IKECalculatorPresenter: IKECalculatorPresenterProtocol {

    private lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencyCode = "PLN"
        formatter.numberStyle = .currency
        formatter.currencyGroupingSeparator = " "
        formatter.maximumFractionDigits = 0
        formatter.locale = .onlyLocale
        return formatter
    }()
    
    private lazy var rateOfReturnFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.multiplier = 1
        return formatter
    }()
    
    weak var viewController: IKECalculatorViewControllerProtocol?
    
    func setUpPresenting() {
        viewController?.loadFormatters(currencyFormatter: currencyFormatter, rateOfReturnFormatter: rateOfReturnFormatter)
    }
    
    func show(futureCapital: Int) {
        viewController?.show(futureCapital: futureCapital)
    }
    
}
