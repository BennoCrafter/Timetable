import UIKit

protocol CardViewDelegate: AnyObject {
    func cardViewDidTap(_ cardView: CardView)
}

class CardView: UIView {
    static let identifier = "CardView"

    weak var delegate: CardViewDelegate?

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var lessonLabel: UILabel!
    @IBOutlet weak var timeEndLabel: UILabel!
    @IBOutlet weak var timeBeginLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }

    func initSubviews() {
        let nib = UINib(nibName: CardView.identifier, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Unable to convert nib") }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)

        timeBeginLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeBeginLabel.font.pointSize, weight: .regular)
        timeEndLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeEndLabel.font.pointSize, weight: .regular)
    }

    func configureText(lessonName: String, timeBegin: String, timeEnd: String) {
        lessonLabel.text = lessonName
        timeBeginLabel.text = timeBegin
        timeEndLabel.text = timeEnd
    }

    @IBAction func onCardClicked(_ sender: Any) {
        print("card clicked")
        delegate?.cardViewDidTap(self)
    }
}
