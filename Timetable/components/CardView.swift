
import Foundation
import UIKit


class CardView: UIView {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        setupView()
    }
    
    private func setupView(){
        startTimeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: startTimeLabel.font.pointSize, weight: .regular)
        endTimeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: endTimeLabel.font.pointSize, weight: .regular)
    }
    
    public func configure(entry: Entry){
        startTimeLabel.text = entry.startTime
        endTimeLabel.text = entry.endTime
        nameLabel.text = entry.subject.name
        
        mainView.backgroundColor = hexStringToUIColor(hex: entry.subject.color)
    }
    
}
