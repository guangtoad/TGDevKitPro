//
//  ViewController.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/11.
//


private var key: Void?

extension UIViewController {
    var dataSouece : NSMutableDictionary {
        get {
            return objc_getAssociatedObject(self, &key) as! NSMutableDictionary
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
/// 视图控制器
class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet var tableView: TableView?
    @IBOutlet var collectionView: UICollectionView?
    
    static func build(nibName nibNameOrNil: String? ,  bundle nibBundleOrNil: Bundle?){
        // bundle?.loadNibNamed(NSStringFromClass(self) ,  owner: nil)
    }
    static func build() -> Void {
        self.build(nibName: NSStringFromClass(self) ,  bundle: Bundle.main)
    }
    @IBOutlet weak var textLabel: UILabel!
    @IBAction func click(_ sender: UIButton){
        
    }
    /// 刷新数据
    func reloadData(){
        self.tableView?.reloadData()
        self.collectionView?.reloadData()
    }
    // MARK: - Inspectable 扩展
    @IBInspectable var borderColor: UIColor = .black
    @GKInspectable var mass: Float = 1.21
    // MARK: - 数据源
    /// 数据源
    lazy var dataSource: NSMutableArray = {
        let dataSource = NSMutableArray()
        return dataSource
    }()
    // MARK: - 生命周期
    /// 视图加载后
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    /// 视图子控件加载前
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    /// 视图子控件加载后
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    /// 视图显现前
    /// - Parameter animated: 是否显示动画
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    /// 视图显现后
    /// - Parameter animated: 是否显示动画
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    /// 视图消失前
    /// - Parameter animated: 是否显示动画
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    /// 视图变化前
    /// - Parameters:
    ///   - size: 尺寸
    ///   - coordinator: coordinator
    override func viewWillTransition(to size: CGSize ,  with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size ,  with: coordinator)
    }
    /// 视图安全区变化
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
    }
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)
    }
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView ,  numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView ,  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)
    }
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView ,  numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView ,  cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell.init()
    }
    
}
