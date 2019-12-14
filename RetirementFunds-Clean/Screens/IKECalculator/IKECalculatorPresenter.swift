protocol IKECalculatorPresenterProtocol {
    func show(futureCapital: Int)
}

final class IKECalculatorPresenter: IKECalculatorPresenterProtocol {
    
    weak var viewController: IKECalculatorViewControllerProtocol?
    
    func show(futureCapital: Int) {
        viewController?.show(futureCapital: "\(futureCapital)")
    }
    
}
