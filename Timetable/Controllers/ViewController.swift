import UIKit


//"colorOptions": [
//      "#63C8BA",
//      "#5BBC73",
//      "#9B61E2",
//      "#EA676A",
//      "#4366CF",
//      "#61A8EC",
//      "#9A742A",
//      "#A7B1C0",
//      "#CB7CE0",
//      "#9AC8EB",
//      "#F09A57"
//  ]

class ViewController: UIViewController {
    let userDefaultsIO = UserDefaultsIO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //userDefaultsIO.clearAll()
        loadExampleData()
        let timetableManager = TimetableManager(entries: userDefaultsIO.loadEntries())
        
        // Initialize the PageViewController
        let pageViewController = PageViewController(timetableManager: timetableManager)

        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        pageViewController.view.frame = view.bounds.offsetBy(dx: 0, dy: 110)
        // Notify the PageViewController that it has been moved to a parent
        pageViewController.didMove(toParent: self)

    }
    
    func loadExampleData(){
        let su: [Subject] = [Subject(id: UUID(), name: "Mathe", color: "#61A8EC"), Subject(id: UUID(), name: "Deutsch", color: "#EA676A")]
        userDefaultsIO.storeSubjects(subjects: su)
        userDefaultsIO.storeEntries(entries: [Entry(id: UUID(), day: .tuesday, startTime: "07:55", endTime: "08:40", subject: su[0]), Entry(id: UUID(), day: .monday, startTime: "07:55", endTime: "08:40", subject: su[1]), Entry(id: UUID(), day: .tuesday, startTime: "08:40", endTime: "09:25", subject: su[1])])
    }
    @IBAction func onAdd(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddLessonView") as? AddLessonView else { return }
        present(vc, animated: true)
    }
    
}
