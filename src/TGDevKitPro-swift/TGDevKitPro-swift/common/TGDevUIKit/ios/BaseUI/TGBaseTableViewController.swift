//
//  TableViewController.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/2/15.
//


class TableViewController: UITableViewController {
    
    var isDataLoaded :Bool = false
    
    let dataArray: NSMutableArray = {
        let dataArray = NSMutableArray()
        return dataArray
    }()
    
    func register(tableView : UITableView) -> Void {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func register() -> Void {
        self.register(tableView: self.tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.register()
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var cell: UITableViewCell? = tableView.cellForRow(at: indexPath)
//        cell?.setSelected(false, animated: true)
//    }
        
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
