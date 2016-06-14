import UIKit

class MusicVideoTVC: UITableViewController, UISearchResultsUpdating {
    
    var videos = [Videos]()

    var filterSearch = [Videos]()
    
    let resultSearchController = UISearchController(searchResultsController: nil)//ako ocemo prikazivati rezultate u istom viewu = nil
    
    var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        reachabilityStatusChanged()
        
    }
    
    func preferredFontChange(){
        print("the preferred font has changeg")
    }
    
    func didLoadData(videos: [Videos]){
        
        print(reachabilityStatus)
        
        self.videos = videos
        
        for(index,item) in videos.enumerate(){
            print("\(index) name = \(item.vName)")
        }
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        
        title = ("The iTunes Top \(limit) Music Videos")
        
        // Setup the Search Controller
        
        resultSearchController.searchResultsUpdater = self
        
        definesPresentationContext = true //search bar ne ostaje na ekranu ako odemo na drugi view
        
        resultSearchController.dimsBackgroundDuringPresentation = false //ako je true onda se vraca na glavni arej, nemos otici u detaljni view controller
        
        resultSearchController.searchBar.placeholder = "Search for Artist"
        
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        
        // add the search bar to your tableview
        tableView.tableHeaderView = resultSearchController.searchBar
        
        tableView.reloadData()
        //
        //        for i in 0..<videos.count{
        //            print("\(i) name = \(videos[i].vName)")
        //        }
    }
    
    func reachabilityStatusChanged()
    {
        switch reachabilityStatus{
        case NOACCESS :
            //view.backgroundColor = UIColor.redColor()
            // move back to Main Queue
            dispatch_async(dispatch_get_main_queue()) {
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
                    action -> () in
                    print("Cancel")
                }
                
                let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
                    action -> () in
                    print("delete")
                }
                let okAction = UIAlertAction(title: "ok", style: .Default) { action -> Void in
                    print("Ok")
                    
                    //do something if you want
                    //alert.dismissViewControllerAnimated(true, completion: nil)
                }
                
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        default:
            //view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("do not refresh API")
            } else {
                runAPI()
            }
        }
    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        
        refreshControl?.endRefreshing()
        
        if resultSearchController.active{
            refreshControl?.attributedTitle = NSAttributedString(string: "Nemores refreshat ako trazis")
        } else {
            runAPI()
        }
        
    }
    
    func getAPICount() {
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil)
        {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            limit = theValue
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDte = formatter.stringFromDate(NSDate())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDte)")
    }

    
    func runAPI(){
        
        getAPICount()
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json",
            completion: didLoadData)
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.active {
            return filterSearch.count
        }
        return videos.count
    }
    
    private struct storyboard{
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
        
        if resultSearchController.active{
            cell.video = filterSearch[indexPath.row]
        } else{
            cell.video = videos[indexPath.row]
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == storyboard.segueIdentifier{
            if let indexPath = tableView.indexPathForSelectedRow{
                
                let video: Videos
                
                if resultSearchController.active{
                    video = filterSearch[indexPath.row]
                } else {
                    video = videos[indexPath.row]
                }
                
                let dvc = segue.destinationViewController as! MusicVideoDetailVC
                dvc.videos = video
            }
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.searchBar.text!.lowercaseString
        filterSearch(searchController.searchBar.text!)
    }
    
    
    func filterSearch(searchText: String) {
        filterSearch = videos.filter { videos in
            return videos.vArtist.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }

    
}
