import UIKit


class CardView: UIView {
    static let identifier = "CardView"

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

        guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                            UIView else {fatalError("Unable to convert nib")}

        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(view)

    }
    
    func configureText(lessonName : String, timeBegin: String, timeEnd: String){
        lessonLabel.text = lessonName
        timeBeginLabel.text = timeBegin
        timeEndLabel.text = timeEnd
    }

}

