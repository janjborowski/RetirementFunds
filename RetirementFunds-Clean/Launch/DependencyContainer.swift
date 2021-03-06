import UIKit
import Swinject

typealias ViewControllerProvider = () -> UIViewController

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
        let router = IKZECalculatorRouter(
            rateOfReturnControllerProvider: rateOfReturnExplanationProvider,
            earlyExitControllerProvider: ikzeEarlyExitProvider
        )
        let useCase = IKZECalculatorUseCase(financialConstants: constants)
        let presenter = IKZECalculatorPresenter()
        let interactor = IKZECalculatorInteractor(router: router, presenter: presenter, ikzeCalculator: useCase, constants: constants)
        let viewController = IKZECalculatorViewController(interactor: interactor)
        
        presenter.viewController = viewController
        router.sourceViewController = viewController
        
        return viewController
    }
    
    func rateOfReturnExplanationProvider() -> UIViewController {
        let viewController = RateOfReturnExplanationViewController()
        return UINavigationController(rootViewController: viewController)
    }
    
    func ikzeEarlyExitProvider(earlyExitTax: IKZEEarlyExitTax?, consumer: IKZECalculatorEarlyExitConsumer) -> UIViewController {
        let presenter = IKZEEarlyExitPresenter()
        let router = IKZEEarlyExitRouter()
        let interactor = IKZEEarlyExitInteractor(
            presenter: presenter,
            router: router,
            financialConstants: .default,
            earlyExitTax: earlyExitTax
        )
        let viewController = IKZEEarlyExitViewController(interactor: interactor)
        
        presenter.controller = viewController
        router.delegate = consumer
        router.currentController = viewController
        
        return UINavigationController(rootViewController: viewController)
    }
    
}
