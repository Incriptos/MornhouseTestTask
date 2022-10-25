import UIKit

final class NumberDetailScreen: UIViewController {
  
  //MARK: - UI Properties
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = .systemFont(ofSize: 30, weight: .bold)
    label.textAlignment = .center
    return label
  }()
  
  private lazy var informationTextView: UITextView = {
    let textView = UITextView()
    textView.font = .systemFont(ofSize: 14, weight: .regular)
    textView.showsVerticalScrollIndicator = false
    textView.showsHorizontalScrollIndicator = false
    textView.isEditable = false
    textView.isSelectable = false
    textView.backgroundColor = .clear
    return textView
  }()
  
  //MARK: - Properties
  public var model: NumberViewModel? = nil {
    didSet {
      updateUI()
    }
  }
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupController()
    setupLayout()
  }
  
  //MARK: - Privates
  private func updateUI() {
    if let model = model {
      titleLabel.text = model.number.toString()
      informationTextView.text = model.text
    }
  }
  
}

//MARK: - Setups
extension NumberDetailScreen {
  
  private func setupController() {
    view.backgroundColor = .white
    
  }
  
  private func setupLayout() {
    [titleLabel, informationTextView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
      titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
      informationTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
      informationTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
      informationTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
      informationTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}
