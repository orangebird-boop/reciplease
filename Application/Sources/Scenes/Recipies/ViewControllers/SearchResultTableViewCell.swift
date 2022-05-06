import UIKit
protocol SearchResultTableViewCellDelegate: AnyObject{
    func didTapButton(with title: String)
}

class SearchResultTableViewCell: UITableViewCell {

    weak var delegate: SearchResultTableViewCellDelegate?
    
    static let identifier = "SearchResultTableViewCell"
    
//    static func nib() -> UINib {
//        return UINib(nibName: "SearchResultTableViewCell", bundle: nil)
//    }

    var button = UIButton()
    private var title: String = ""
    
    func configure(with title: String) {
        self.title = title
        button.setTitle(title, for: .normal)
    }
    
    @objc
    func didtapButton() {
        delegate?.didTapButton(with: <#T##String#>)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.setTitleColor(.link, for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
