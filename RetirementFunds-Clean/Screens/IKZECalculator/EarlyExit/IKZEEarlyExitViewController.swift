import UIKit
import Eureka

protocol IKZEEarlyExitViewControllerProtocol: AnyObject {
    func showOptions()
    func hideOptions()
    func set(options: [String])
    
    func showNoEarlyExit()
    func showFlatRateExitTax(option: String)
    func showProgressiveRate(option: String, income: Int)
}

final class IKZEEarlyExitViewController: FormViewController {
    
    private let interactor: IKZEEarlyExitInteractorProtocol
    
    private enum RowTag: String {
        case earlyExitSwitch
        case options
        case yearToDateIncome
    }
    
    init(interactor: IKZEEarlyExitInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpForm()
        setUpBarButtons()
        interactor.setUp()
    }
    
    private func setUpForm() {
        form +++ Section("tax_bracket".localized)
            <<< SwitchRow(RowTag.earlyExitSwitch.rawValue) {
                $0.title = "early_exit".localized
            }.onChange { [weak self] (row) in
                self?.interactor.update(isEarlyExit: row.value)
            }
            <<< SegmentedRow<String>(RowTag.options.rawValue) {
                $0.title = ""
            }.onChange { [weak self] (row) in
                let index = row.options?.firstIndex(of: row.value ?? "")
                self?.interactor.pickEarlyExitOption(index: index)
            }
        
        form +++ Section()
            <<< IntRow(RowTag.yearToDateIncome.rawValue) { row in
                row.title = "year_to_date_income".localized
            }.cellUpdate { [weak self] (_, row) in
                self?.interactor.update(yearToDateIncome: row.value)
            }
    }
    
    private func setUpBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func cancelButtonTapped() {
        interactor.cancel()
    }
    
    @objc private func saveButtonTapped() {
        interactor.saveAndExit()
    }
    
}

extension IKZEEarlyExitViewController: IKZEEarlyExitViewControllerProtocol {
    
    private var earlyExitSwitchRow: SwitchRow? {
        return form.rowBy(tag: RowTag.earlyExitSwitch.rawValue) as? SwitchRow
    }
    
    private var optionsRow: SegmentedRow<String>? {
        return form.rowBy(tag: RowTag.options.rawValue) as? SegmentedRow<String>
    }
    
    private var yearToDateIncomeRow: IntRow? {
        return form.rowBy(tag: RowTag.yearToDateIncome.rawValue) as? IntRow
    }
    
    func showOptions() {
        show(row: optionsRow)
    }
    
    func hideOptions() {
        hide(row: optionsRow)
    }
  
    func showNoEarlyExit() {
        updateRowSilently(row: earlyExitSwitchRow, value: false)
        hide(row: optionsRow)
        hide(row: yearToDateIncomeRow)
    }
    
    func showFlatRateExitTax(option: String) {
        updateRowSilently(row: earlyExitSwitchRow, value: true)
        
        updateRowSilently(row: optionsRow, value: option)
        show(row: optionsRow)
        
        updateRowSilently(row: yearToDateIncomeRow, value: nil)
        hide(row: yearToDateIncomeRow)
    }
    
    func showProgressiveRate(option: String, income: Int) {
        updateRowSilently(row: earlyExitSwitchRow, value: true)
        
        updateRowSilently(row: optionsRow, value: option)
        show(row: optionsRow)
        
        updateRowSilently(row: yearToDateIncomeRow, value: income)
        show(row: yearToDateIncomeRow)
    }
    
    func set(options: [String]) {
        optionsRow?.options = options
    }
    
}

extension FormViewController {
    
    func show(row: BaseRow?) {
        row?.hidden = false
        row?.evaluateHidden()
    }
    
    func hide(row: BaseRow?) {
        row?.hidden = true
        row?.evaluateHidden()
    }
    
    func updateRowSilently<T>(row: Row<T>?, value: T.Value?) {
        form.delegate = nil
        row?.value = value
        form.delegate = self
    }
    
}
