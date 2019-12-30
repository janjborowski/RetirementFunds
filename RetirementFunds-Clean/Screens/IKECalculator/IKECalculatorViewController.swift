import UIKit
import Eureka

protocol IKECalculatorViewControllerProtocol: AnyObject {
    func loadFormatters(currencyFormatter: Formatter, rateOfReturnFormatter: Formatter)
    func show(futureCapital: Int)
}

final class IKECalculatorViewController: FormViewController {
    
    private enum RowTag: String {
        case annualInput
        case rateOfReturn
        case futureCapital
    }
    
    private let interactor: IKECalculatorInteractorProtocol
    private let basicRateOfReturn = 4
    
    init(interactor: IKECalculatorInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpForm()
        interactor.setUp()
        title = "ike".localized
    }
    
    private func setUpForm() {
        form +++ Section()
            <<< IntRow(RowTag.annualInput.rawValue) { row in
                row.title = "annual_input".localized
            }.cellUpdate { [weak self] (_, row) in
                self?.interactor.update(annualInput: row.value)
            }
            <<< IntRow() { row in
                row.title = "years_to_retirement".localized
            }.cellUpdate { [weak self] (_, row) in
                self?.interactor.update(yearsToRetirement: row.value)
            }
            <<< IntRow(RowTag.rateOfReturn.rawValue) {
                $0.title = "rate_of_return".localized
                $0.value = basicRateOfReturn
                $0.cell.accessoryType = .detailButton
            }.cellUpdate { [weak self] (_, row) in
                self?.interactor.update(rateOfReturn: row.value)
            }
            <<< SwitchRow() {
                $0.title = "early_exit".localized
            }.onChange { [weak self] (row) in
                self?.interactor.update(earlyExit: row.value)
            }
        
        form +++ Section()
            <<< IntRow(RowTag.futureCapital.rawValue) { row in
                row.title = "future_capital".localized
                row.cell.textField.isUserInteractionEnabled = false
            }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard form.rowBy(tag: RowTag.rateOfReturn.rawValue)?.indexPath == indexPath else {
            return
        }
        
        interactor.showRateOfReturnExplanation()
    }
    
}

extension IKECalculatorViewController: IKECalculatorViewControllerProtocol {
    
    func loadFormatters(currencyFormatter: Formatter, rateOfReturnFormatter: Formatter) {
        load(currencyFormatter: currencyFormatter)
        load(rateOfReturnFormatter: rateOfReturnFormatter)
    }
    
    private func load(currencyFormatter: Formatter) {
        guard let annualInputRow = form.rowBy(tag: RowTag.annualInput.rawValue) as? IntRow,
            let futureCapitalRow = form.rowBy(tag: RowTag.futureCapital.rawValue) as? IntRow else {
                return
        }
        
        annualInputRow.formatter = currencyFormatter
        futureCapitalRow.formatter = currencyFormatter
    }
    
    private func load(rateOfReturnFormatter: Formatter) {
        guard let rateOfReturnRow = form.rowBy(tag: RowTag.rateOfReturn.rawValue) as? IntRow else {
                return
        }
        
        rateOfReturnRow.formatter = rateOfReturnFormatter
    }
    
    func show(futureCapital: Int) {
        guard let futureCapitalRow = form.rowBy(tag: RowTag.futureCapital.rawValue) as? IntRow else {
            return
        }
        
        futureCapitalRow.value = futureCapital
        futureCapitalRow.reload()
    }
    
}
