import UIKit

protocol OptionsListViewControllerProtocol: AnyObject {
    
    func display(data cellViewModels: [OptionsListCellViewModel])
    
}

final class OptionsListViewController: UITableViewController {
    
    private let interactor: OptionsListInteractorProtocol
    private var cellViewModels = [OptionsListCellViewModel]()
    
    init(interactor: OptionsListInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        title = "options_list_title".localized
        
        interactor.requestContent()
    }
    
    private func setUpTableView() {
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.backgroundColor = UIColor.secondarySystemBackground
        tableView.register(OptionsListCell.self, forCellReuseIdentifier: OptionsListCell.reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionsListCell.reuseIdentifier) as? OptionsListCell else {
            return UITableViewCell()
        }
        
        let cellViewModel = cellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = cellViewModels[indexPath.row]
        interactor.goToCalculator(with: cellViewModel.option)
    }
    
}

extension OptionsListViewController: OptionsListViewControllerProtocol {
    func display(data cellViewModels: [OptionsListCellViewModel]) {
        self.cellViewModels = cellViewModels
        tableView.reloadData()
    }
}
