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
        let errorRow = LabelRow() {
            let limitFormatted = NumberFormatter.currencyFormatter.string(for: limit) ?? ""
            $0.title = String(format: "ike_limit_exceeded".localized, limitFormatted)
            $0.cell.height = { 35 }
            $0.cell.backgroundColor = .red
            $0.cell.textLabel?.numberOfLines = 0
            $0.cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        }.cellUpdate { (cell, row) in
            cell.textLabel?.textColor = .white
        }
        viewController?.showInvalidAnnualInput(errorRow: errorRow)
    }
    
}
