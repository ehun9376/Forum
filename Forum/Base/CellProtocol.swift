//
//  CellProtocol.swift
//  BlackSreenVideo
//
//  Created by yihuang on 2022/11/26.
//

import Foundation
import UIKit

public protocol CellBinding {
    func setupCellView(model: CellModelBase)
}

public protocol CellModelBase {
    func cellReUseID() -> String
}

public class CollectionItemModel: CellModelBase {
    
    var itemSize: CGSize?
    var indexPath: IndexPath?
    
    var cellDidPressed: ((CollectionItemModel?) -> ())?
    weak var collectionView: UICollectionView?

    public func cellReUseID() -> String {
        fatalError("Need Override")
    }
    
    init(itemSize: CGSize? = nil, itemDidSelectAction: ((CollectionItemModel?) -> ())? = nil) {
        self.itemSize = itemSize
        if let itemDidSelectAction = itemDidSelectAction {
            self.cellDidPressed = itemDidSelectAction
        }
    }
    
    public func updateCellView(){
        if let indexPath = self.indexPath {
            self.collectionView?.reloadItems(at: [indexPath])
        }
    }

}




open class CellRowModel: CellModelBase {
    
    open func cellReUseID() -> String {
        fatalError("Need Override ")
    }
    
    public var cellDidSelect: ((CellRowModel)->())?
    
    public var indexPath: IndexPath?
    
    weak var tableView: UITableView?
    
    public init(){}
    
    public func updateCellView() {
        DispatchQueue.main.async {
            if let tableView = self.tableView {
                tableView.reloadRows(at: [self.indexPath ?? IndexPath()], with: .none)
            }
        }

    }
}
