import Foundation
import UIKit

class SearchTableView: UIView {
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.register(SerachTableViewCell.self, forCellReuseIdentifier: "CellId")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
