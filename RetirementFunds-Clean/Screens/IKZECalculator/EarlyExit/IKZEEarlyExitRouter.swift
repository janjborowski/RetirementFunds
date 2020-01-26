import Foundation
import UIKit

protocol IKZEEarlyExitRouterProtocol {
    
    func cancel()
    func save(earlyExitTax: IKZESavingsPlan.EarlyExitTax?)
    
}

final class IKZEEarlyExitRouter: IKZEEarlyExitRouterProtocol {
    
    weak var currentController: UIViewController?
    weak var delegate: IKZECalculatorEarlyExitConsumer?
    
    func cancel() {
        currentController?.dismiss(animated: true, completion: nil)
    }
    
    func save(earlyExitTax: IKZESavingsPlan.EarlyExitTax?) {
        delegate?.save(earlyExit: earlyExitTax)
        currentController?.dismiss(animated: true, completion: nil)
    }
    
}
