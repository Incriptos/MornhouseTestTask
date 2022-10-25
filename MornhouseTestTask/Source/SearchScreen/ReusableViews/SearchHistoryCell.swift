import UIKit

final class SearchHistoryCell: UITableViewCell {
  
  //MARK: - UI Properties
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = .systemFont(ofSize: 14, weight: .bold)
    return label
  }()
  
  private let infoLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = .systemFont(ofSize: 12, weight: .regular)
    return label
  }()
  
  //MARK: - Initialization
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCell()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupCell()
    setupLayout()
  }
  
}

//MARK: - Setups
extension SearchHistoryCell {
  
  private func setupCell() {
    selectionStyle = .none
    backgroundColor = .clear
  }
  
  private func setupLayout() {
    [titleLabel, infoLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
      titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
      infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
      infoLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
      infoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
      infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
    
  }
  
  public func populate(_ object: NumberViewModel) {
    titleLabel.text = object.number.toString()
    infoLabel.text = object.text
  }
  
}
