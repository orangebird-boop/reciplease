import Foundation
import UIKit

class SearchTableView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
    }
    
   
    let tableView = UITableView()
    let dataSource = MyIngredientsDataSource()
    
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
