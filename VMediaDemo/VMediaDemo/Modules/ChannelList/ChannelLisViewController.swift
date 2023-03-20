//
//  ChannelLisViewController.swift
//  VMediaDemo
//
//  Created by Abhishek Binniwale on 19/03/23.
//

import UIKit

class ChannelLisViewController: UIViewController {

    @IBOutlet weak var channelCollectionView: UICollectionView! {
        didSet{
            channelCollectionView.bounces = false
        }
    }
    
    @IBOutlet weak var gridLayout: StickyGridCollectionViewLayout! {
            didSet {
                gridLayout.stickyRowsCount = 1
                gridLayout.stickyColumnsCount = 1
            }
        }

    var presenter: ViewToPresenterChannelListProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension ChannelLisViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSection() ?? 0 + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItemsInSection(section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCollectionViewCell.reuseID, for: indexPath) as? ChannelCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.titleLabel.text = "Today"
        } else if indexPath.row == 0 {
            let channel = presenter?.channelAt(index: indexPath.section - 1)
            cell.titleLabel.text = "\(channel?.CallSign ?? "")"
        } else if indexPath.section == 0 {
            //Needs to set the time label here
            //let timeText = presenter?.timeLabelText(index: indexPath.row)
            cell.titleLabel.text = "1:30"
        } else {
            let program = presenter?.programAt(section: indexPath.section, row: indexPath.row)
            cell.titleLabel.text = "\(program?.name ?? "")"
        }
        
        let isItemSticky = gridLayout.isItemSticky(at: indexPath)
        let darkBlue =  UIColor(red: 17/255, green: 23/255, blue: 39/255, alpha: 1)
        let secondaryBlue =  UIColor(red: 14/255, green: 29/255, blue: 60/255, alpha: 1)
        cell.backgroundColor = isItemSticky ? darkBlue : secondaryBlue
        
        return cell
    }
    

}

extension ChannelLisViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
}

// MARK: - Presenter To View Delegate Method

extension ChannelLisViewController: PresenterToViewChannelListProtocol {
    func onFetchChannelListSuccess() {
        DispatchQueue.main.async {
            self.channelCollectionView.reloadData()
        }
    }
    
    func onFetchChannelListFailure(error: String) {
        //can show the error alert for this.
    }
    
}
