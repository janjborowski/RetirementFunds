import UIKit

final class OptionsListViewController: UITableViewController {
    
    private let viewModel: OptionsListViewModelProtocol
    
    init(viewModel: OptionsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "options_list_title".localized
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.backgroundColor = UIColor.secondarySystemBackground
        tableView.register(OptionsListCell.self, forCellReuseIdentifier: OptionsListCell.reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionsListCell.reuseIdentifier) as? OptionsListCell else {
            return UITableViewCell()
        }
        
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToCalculator(at: indexPath.row)
    }
    
}
