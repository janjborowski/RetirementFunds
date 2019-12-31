import Foundation
import Eureka

protocol IKECalculatorPresenterProtocol {
    func setUpPresenting()
    func show(futureCapital: Int)
    
    func showValidAnnualInput()
    func showInvalidAnnualInput(limit: Int)
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
    
    func showValidAnnualInput() {
        viewController?.showValidAnnualInput()
    }
    
    func showInvalidAnnualInput(limit: Int) {
        let errorRow = LabelRow() {
            let limitFormatted = currencyFormatter.string(for: limit) ?? ""
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
