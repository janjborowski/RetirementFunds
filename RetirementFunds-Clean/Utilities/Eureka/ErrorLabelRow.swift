import Eureka

final class ErrorLabelRow: _LabelRow, RowType {
    
    required init(tag: String? = nil) {
        super.init(tag: tag)
        cell.height = { 35 }
        cell.backgroundColor = .red
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        cellUpdate { (cell, _) in
            cell.textLabel?.textColor = .white
        }
    }
    
}
