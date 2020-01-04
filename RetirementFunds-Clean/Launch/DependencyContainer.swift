import UIKit
import Swinject

final class DependencyContainer {
    
    private let container = Container()
    private let constants = FinancialConstants.default
    
    init() {}
    
    func createInitialController() -> UIViewController {
        let router = OptionsListRouter(ikeCalculatorProvider: ikeCalculatorProvider, ikzeCalculatorProvider: ikzeCalculatorProvider)
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
        let interactor = IKECalculatorInteractor(router: router, presenter: presenter, ikeCalculator: useCase, basicRateOfReturn: constants.basicRateOfReturn)
        let viewController = IKECalculatorViewController(interactor: interactor)
        
        presenter.viewController = viewController
        router.sourceViewController = viewController
        
        return viewController
    }
    
    func ikzeCalculatorProvider() -> UIViewController {
        let router = IKZECalculatorRouter(rateOfReturnControllerProvider: rateOfReturnExplanationProvider)
//        let useCase = IKECalculatorUseCase()
        let presenter = IKZECalculatorPresenter()
        let interactor = IKZECalculatorInteractor(router: router, presenter: presenter, basicRateOfReturn: constants.basicRateOfReturn)//, ikeCalculator: useCase)
        let viewController = IKZECalculatorViewController(interactor: interactor)
        
        presenter.viewController = viewController
        router.sourceViewController = viewController
        
        return viewController
    }
    
    func rateOfReturnExplanationProvider() -> UIViewController {
        let viewController = RateOfReturnExplanationViewController()
        return UINavigationController(rootViewController: viewController)
    }
    
}
