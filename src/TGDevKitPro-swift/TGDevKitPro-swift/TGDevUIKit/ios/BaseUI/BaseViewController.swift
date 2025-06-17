//
//  BaseViewController.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/2/14.
//

import UIKit

class BaseViewController: UIViewController {
    
    static func build(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
//        bundle?.loadNibNamed(NSStringFromClass(self), owner: nil)
    }
    
    static func build() -> Void {
        self.build(nibName: NSStringFromClass(self), bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBAction func click(_ sender: UIResponder){
        
    }
    
    @IBInspectable var borderColor: UIColor = .black
    @GKInspectable var mass: Float = 1.21
    
    /// 数据源
    lazy var dataSource: NSMutableArray = {
        let dataSource = NSMutableArray()
        return dataSource
    }()

}
