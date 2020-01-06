import UIKit
import Eureka

protocol IKZECalculatorViewControllerProtocol: AnyObject {
    func loadFormatters(currencyFormatter: Formatter, rateOfReturnFormatter: Formatter)
    func load(rateOfReturn: Int)
    
    func showValidAnnualInput()
    func showInvalidAnnualInput(errorRow: ErrorLabelRow)
    
    func show(futureCapital: Int, taxReturn: Int)
}

final class IKZECalculatorViewController: FormViewController {
    
    private enum RowTag: String {
        case annualInput
        case annualInputError
        case rateOfReturn
        case futureCapital
        case taxReturn
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
        form +++ Section()
            <<< IntRow(RowTag.annualInput.rawValue) { row in
                row.title = "annual_input".localized
            }.cellUpdate { [weak self] (_, row) in
                self?.interactor.update(annualInput: row.value)
            }
            <<< IntRow() { row in
                row.title = "years_to_retirement".localized
            }.cellUpdate { [weak self] (_, row) in
                self?.interactor.update(yearsToRetire: row.value)
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
            <<< IntRow(RowTag.taxReturn.rawValue) { row in
                row.title = "tax_return".localized
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
        load(formatter: currencyFormatter, in: .annualInput)
        load(formatter: currencyFormatter, in: .futureCapital)
        load(formatter: currencyFormatter, in: .taxReturn)
        load(formatter: rateOfReturnFormatter, in: .rateOfReturn)
    }
    
    private func load(formatter: Formatter, in rowTag: RowTag) {
        guard let row = find(intRow: rowTag) else {
            return
        }
        
        row.formatter = formatter
    }
    
    func load(rateOfReturn: Int) {
        reload(intRow: .rateOfReturn, with: rateOfReturn)
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
    
    func show(futureCapital: Int, taxReturn: Int) {
        reload(intRow: .futureCapital, with: futureCapital)
        reload(intRow: .taxReturn, with: taxReturn)
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
    
    private func reload(intRow tag: RowTag, with value: Int) {
        guard let row = find(intRow: tag) else {
            return
        }
        
        row.value = value
        row.reload()
    }
    
}
