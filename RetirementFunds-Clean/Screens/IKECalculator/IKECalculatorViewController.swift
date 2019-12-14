import UIKit
import Eureka

protocol IKECalculatorViewControllerProtocol: AnyObject {
    func show(futureCapital: String)
}

final class IKECalculatorViewController: FormViewController {
    
    private enum RowTag: String {
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
        title = "ike".localized
    }
    
    private func setUpForm() {
        form +++ Section()
            <<< IntRow() { row in
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
                let formatter = NumberFormatter()
                formatter.numberStyle = .percent
                formatter.multiplier = 1
                $0.formatter = formatter
                $0.value = basicRateOfReturn
                $0.cell.accessoryType = .detailButton
            }
        
        form +++ Section()
            <<< TextRow(RowTag.futureCapital.rawValue) { row in
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
    
    func show(futureCapital: String) {
        guard let textRow = form.rowBy(tag: RowTag.futureCapital.rawValue) as? TextRow else {
            return
        }
        
        textRow.cell.textField.text = futureCapital
    }
    
}
