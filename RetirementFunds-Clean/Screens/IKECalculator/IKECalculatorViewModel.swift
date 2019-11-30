protocol IKECalculatorViewModelProtocol {

    func update(annualInput: Int?)
    func update(yearsToRetirement: Int?)

}

final class IKECalculatorViewModel: IKECalculatorViewModelProtocol {
    
    private var annualInput: Int?
    private var yearsToRetirement: Int?
    
    func update(annualInput: Int?) {
        self.annualInput = annualInput
    }
    
    func update(yearsToRetirement: Int?) {
        self.yearsToRetirement = yearsToRetirement
    }
    
}
