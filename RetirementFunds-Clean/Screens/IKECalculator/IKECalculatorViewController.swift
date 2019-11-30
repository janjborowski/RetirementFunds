import UIKit
import Eureka

final class IKECalculatorViewController: FormViewController {
    
    private var viewModel: IKECalculatorViewModelProtocol?
    
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
                self?.viewModel?.update(annualInput: row.value)
            }
            <<< IntRow() { row in
                row.title = "years_to_retirement".localized
            }.cellUpdate { [weak self] (_, row) in
                self?.viewModel?.update(yearsToRetirement: row.value)
            }
    }
    
}
