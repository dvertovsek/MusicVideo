import UIKit

class ViewController: UIViewController {
    
    var videos = [Video]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        //call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json",
            completion: didLoadData)
    }
    
    func didLoadData(videos: [Video]){
        
        print(reachabilityStatus)
        
        self.videos = videos
        
        for(index,item) in videos.enumerate(){
            print("\(index) name = \(item.vName)")
        }
        
        tableView.reloadData()
        //
        //        for i in 0..<videos.count{
        //            print("\(i) name = \(videos[i].vName)")
        //        }
    }
    
    func reachabilityStatusChanged()
    {
        
        switch reachabilityStatus {
        case NOACCESS : view.backgroundColor = UIColor.redColor()
        displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.greenColor()
        displayLabel.text = "Reachable with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
        displayLabel.text = "Reachable with Cellular"
        default:return
        }
        
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }
    
}

