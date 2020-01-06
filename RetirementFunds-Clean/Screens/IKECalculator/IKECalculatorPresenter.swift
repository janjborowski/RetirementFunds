import Foundation
import Eureka

protocol IKECalculatorPresenterProtocol {
    func setUpPresenting(rateOfReturn: Int)
    func show(futureCapital: Int)
    
    func showValidAnnualInput()
    func showInvalidAnnualInput(limit: Int)
}

final class IKECalculatorPresenter: IKECalculatorPresenterProtocol {
    
    weak var viewController: IKECalculatorViewControllerProtocol?
    
    func setUpPresenting(rateOfReturn: Int) {
        viewController?.loadFormatters(
            currencyFormatter: NumberFormatter.currencyFormatter,
            rateOfReturnFormatter: NumberFormatter.rateOfReturnFormatter
        )
        viewController?.load(rateOfReturn: rateOfReturn)
    }
    
    func show(futureCapital: Int) {
        viewController?.show(futureCapital: futureCapital)
    }
    
    func showValidAnnualInput() {
        viewController?.showValidAnnualInput()
    }
    
    func showInvalidAnnualInput(limit: Int) {
        let errorRow = ErrorLabelRow() {
            let limitFormatted = NumberFormatter.currencyFormatter.string(for: limit) ?? ""
            $0.title = String(format: "input_limit_exceeded".localized, limitFormatted)
        }
        viewController?.showInvalidAnnualInput(errorRow: errorRow)
    }
    
}
