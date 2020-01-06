import Foundation

protocol IKZECalculatorPresenterProtocol {
    func setUpPresenting(rateOfReturn: Int)
    
    func showValidAnnualInput()
    func showInvalidAnnualInput(limit: Int)
    
    func show(futureCapital: Int, taxReturn: Int)
}

final class IKZECalculatorPresenter: IKZECalculatorPresenterProtocol {
    
    weak var viewController: IKZECalculatorViewControllerProtocol?
    
    func setUpPresenting(rateOfReturn: Int) {
        viewController?.loadFormatters(
            currencyFormatter: NumberFormatter.currencyFormatter,
            rateOfReturnFormatter: NumberFormatter.rateOfReturnFormatter
        )
        viewController?.load(rateOfReturn: rateOfReturn)
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
    
    func show(futureCapital: Int, taxReturn: Int) {
        viewController?.show(futureCapital: futureCapital, taxReturn: taxReturn)
    }
    
}
