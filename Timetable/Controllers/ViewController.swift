import UIKit


// "colorOptions": [
//     "#63C8BA", // teal
//     "#5BBC73", // green
//     "#9B61E2", // purple
//     "#EA676A", // red
//     "#4366CF", // blue
//     "#61A8EC", // light blue
//     "#9A742A", // brown
//     "#A7B1C0", // gray
//     "#CB7CE0", // light purple
//     "#9AC8EB", // light blue
//     "#F09A57"  // orange
// ]


class ViewController: UIViewController {
    let userDefaultsIO = UserDefaultsIO()
    var portraitPageViewController: PageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //userDefaultsIO.clearAll()
        
        let timetableManager = TimetableManager(events: userDefaultsIO.loadEvents())
        
        //userDefaultsIO.saveEvents(events: timetableManager.events)
        
        // timetableManager.printEvents()
        
        // Initialize the PageViewController
        portraitPageViewController = PageViewController(timetableManager: timetableManager)
        
        addChild(portraitPageViewController)
        view.addSubview(portraitPageViewController.view)
        
        portraitPageViewController.view.frame = view.bounds.offsetBy(dx: 0, dy: 110)
        // Notify the PageViewController that it has been moved to a parent
        portraitPageViewController.didMove(toParent: self)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.handleDeviceRotation()
        }, completion: nil)
    }
    
    func handleDeviceRotation() {
        // Check device orientation
        if UIDevice.current.orientation.isLandscape {
            print("isLandscape")
        }else if UIDevice.current.orientation.isPortrait{
            print("isPortait")
        }
    }
    
    
    @IBAction func onAdd(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddLessonView") as? AddLessonView else { return }
        present(vc, animated: true)
    }
    
}
