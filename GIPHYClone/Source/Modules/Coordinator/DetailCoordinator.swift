//
//  DetailCoordinator.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/05.
//

import UIKit

protocol Coordinator: AnyObject {
    func pushToDetail(_ navigationController: UINavigationController?, data: Datum)
}

class DetailCoordinator: Coordinator {
    func pushToDetail(_ navigationController: UINavigationController?, data: Datum) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailVC = (storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController)!
        detailVC.vm.gifData = data
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
