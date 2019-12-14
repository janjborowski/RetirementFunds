import UIKit
import Swinject

final class DependencyContainer {
    
    private let container = Container()
    
    init() {}
    
    func createInitialController() -> UIViewController {
        let router = OptionsListRouter(ikeCalculatorProvider: ikeCalculatorProvider)
        let presenter = OptionsListPresenter()
        let interactor = OptionsListInteractor(router: router, presenter: presenter)
        let viewController = OptionsListViewController(interactor: interactor)
        let rootController = UINavigationController(rootViewController: viewController)
    
        presenter.viewController = viewController
        
        router.sourceViewController = rootController
        return rootController
    }
    
    func ikeCalculatorProvider() -> UIViewController {
        let router = IKECalculatorRouter(rateOfReturnControllerProvider: rateOfReturnExplanationProvider)
        let useCase = IKECalculatorUseCase()
        let presenter = IKECalculatorPresenter()
        let interactor = IKECalculatorInteractor(router: router, presenter: presenter, ikeCalculator: useCase)
        let viewController = IKECalculatorViewController(interactor: interactor)
        
        presenter.viewController = viewController
        router.sourceViewController = viewController
        
        return viewController
    }
    
    func rateOfReturnExplanationProvider() -> UIViewController {
        let viewController = RateOfReturnExplanationViewController()
        return UINavigationController(rootViewController: viewController)
    }
    
}
