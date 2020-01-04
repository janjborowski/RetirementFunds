import UIKit
import Eureka

protocol IKZECalculatorViewControllerProtocol: AnyObject {
    func loadFormatters(currencyFormatter: Formatter, rateOfReturnFormatter: Formatter)
    func load(rateOfReturn: Int)
    
    func showValidAnnualInput()
    func showInvalidAnnualInput(errorRow: ErrorLabelRow)
}

final class IKZECalculatorViewController: FormViewController {
    
    private enum RowTag: String {
        case annualInput
        case annualInputError
        case rateOfReturn
        case futureCapital
    }
    
    private let interactor: IKZECalculatorInteractorProtocol
    
    init(interactor: IKZECalculatorInteractorProtocol) {
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
        title = "ikze".localized
    }
    
    private func setUpForm() {
        form +++ Section(RowTag.annualInput.rawValue)
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
                $0.cell.accessoryType = .detailButton
            }.cellUpdate { [weak self] (_, row) in
                self?.interactor.update(rateOfReturn: row.value)
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

extension IKZECalculatorViewController: IKZECalculatorViewControllerProtocol {
    
    func loadFormatters(currencyFormatter: Formatter, rateOfReturnFormatter: Formatter) {
        load(currencyFormatter: currencyFormatter)
        load(rateOfReturnFormatter: rateOfReturnFormatter)
    }
    
    private func load(currencyFormatter: Formatter) {
        guard let annualInputRow = find(intRow: .annualInput),
            let futureCapitalRow = find(intRow: .futureCapital) else {
                return
        }
        
        annualInputRow.formatter = currencyFormatter
        futureCapitalRow.formatter = currencyFormatter
    }
    
    private func load(rateOfReturnFormatter: Formatter) {
        guard let rateOfReturnRow = find(intRow: .rateOfReturn) else {
            return
        }
        
        rateOfReturnRow.formatter = rateOfReturnFormatter
    }
    
    func load(rateOfReturn: Int) {
        guard let rateOfReturnRow = find(intRow: .rateOfReturn) else {
            return
        }
        
        rateOfReturnRow.value = rateOfReturn
        rateOfReturnRow.reload()
    }
    
    func showValidAnnualInput() {
        guard let errorRow = find(labelRow: .annualInputError),
            let index = errorRow.indexPath?.row else {
            return
        }
        
        errorRow.section?.remove(at: index)
    }
    
    func showInvalidAnnualInput(errorRow: ErrorLabelRow) {
        guard let annualInputRow = find(intRow: .annualInput),
            form.rowBy(tag: RowTag.annualInputError.rawValue) == nil else {
                return
        }
        
        errorRow.tag = RowTag.annualInputError.rawValue
        try? annualInputRow.section?.insert(row: errorRow, after: annualInputRow)
    }
    
    private func find<T: RowType>(row tag: RowTag) -> T? {
        return form.rowBy(tag: tag.rawValue)
    }
    
    private func find(intRow tag: RowTag) -> IntRow? {
        return find(row: tag)
    }
    
    private func find(labelRow tag: RowTag) -> LabelRow? {
        return find(row: tag)
    }
    
}
