protocol OptionsListPresenterProtocol {
    func showCells(options: [RetirementPlanOption])
}

final class OptionsListPresenter: OptionsListPresenterProtocol {
    
    weak var viewController: OptionsListViewControllerProtocol?
    
    func showCells(options: [RetirementPlanOption]) {
        let cellViewModels = options.map { option -> OptionsListCellViewModel in
            let title: String
            let subtitle: String
            switch option {
            case .ike:
                title = "IKE"
                subtitle = "Indywidualne Konto Emerytalne"
            case .ikze:
                title = "IKZE"
                subtitle = "Indywidualne Konto Zabepieczenia Emerytalnego"
            case .ppk:
                title = "PPK"
                subtitle = "Pracownicze Plany Kapitałowe"
            }
            return OptionsListCellViewModel(title: title, subtitle: subtitle, option: option)
        }
        viewController?.display(data: cellViewModels)
    }
}
