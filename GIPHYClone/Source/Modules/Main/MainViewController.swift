//
//  MainViewController.swift
//  GIPHYClone
//
//  Created by 박지현 on 2021/07/06.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    let coordinator: DetailCoordinator = DetailCoordinator()
    let vm: MainViewModel = MainViewModel()
    let pinterestLayout = PinterestLayout()
    
    var cellWidth = 0.0
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noDataView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
        vm.getList() { success, errMsg in
            if success { self.collectionView.reloadData() }
            else { self.makeAlert(msg: errMsg!) }
        }
    }
    
    func setCollection() {
        pinterestLayout.delegate = self
        collectionView.collectionViewLayout = pinterestLayout
        cellWidth = Double((view.bounds.width - 4) / 2)
    }
    
    func clearCollectionView() {
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionView.ScrollPosition(), animated: true)
        self.pinterestLayout.cache = []
        self.collectionView.collectionViewLayout = self.pinterestLayout
    }
    
    func makeAlert(msg: String) -> Void {
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        var okAction : UIAlertAction
        okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard var text = searchBar.text else {
            return
        }
        self.view.endEditing(true)
        text = text.trimmingCharacters(in: .whitespaces)
        if text == "" {
            vm.getList { success, errMsg in
                if success { self.collectionView.reloadData() }
                else { self.makeAlert(msg: errMsg!) }
            }
            return
        }
        vm.searchList(query: text) { success, errMsg in
            if success {
                self.clearCollectionView()
                self.noDataView.isHidden = true
                self.collectionView.reloadData()
            }
            else {
                self.noDataView.isHidden = false
                self.makeAlert(msg: errMsg!)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        vm.changeSearchType()
        guard var text = searchBar.text else {
            return
        }
        text = text.trimmingCharacters(in: .whitespaces)
        clearCollectionView()
        if text == "" {
            vm.getList { success, errMsg in
                if success { self.collectionView.reloadData() }
                else { self.makeAlert(msg: errMsg!) }
            }
        }
        else {
            vm.searchList(query: text) { success, errMsg in
                if success {
                    self.noDataView.isHidden = true
                    self.collectionView.reloadData()
                }
                else {
                    self.noDataView.isHidden = false
                    self.makeAlert(msg: errMsg!)
                }
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let cnt = indexPath.item
        return vm.getNewHeight(img: vm.getPreView(cnt: cnt), cellWidth: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.listCnt()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as? ImgCell else {
            return UICollectionViewCell()
        }
        
        let cnt = indexPath.item
        cell.update(img: vm.getPreView(cnt: cnt), width: Double(cellWidth))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cnt = indexPath.item
        coordinator.pushToDetail(self.navigationController, data: vm.data.list[cnt])
    }
}

extension MainViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            if vm.searchText == "" {
                vm.fetchList(){ success, errMsg in
                    if success{ self.insertGifs() }
                    else { self.makeAlert(msg: errMsg!) }
                }
            }
            else {
                vm.fetchSearchList() { success, errMsg in
                    if success { self.insertGifs() }
                    else { self.makeAlert(msg: errMsg!) }
                }
            }
        }
    }
    
    func insertGifs() {
        UICollectionView.animate(withDuration: 0, animations: { [self] in
            self.collectionView.performBatchUpdates({
                for i in stride(from: self.vm.data.pagination.count, to: 0, by: -1) {
                    let indexPath = IndexPath(row: vm.listCnt() - i, section: 0)
                    self.collectionView.insertItems(at: [indexPath])
                }
            }, completion: nil)
        })
    }
}
