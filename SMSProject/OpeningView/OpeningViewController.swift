//
// SMSView.swift
//  SMSProject
//
//  Created by Ade Adegoke on 12/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//
import Foundation
import UIKit

class OpeningViewController: UIViewController {

    @IBOutlet weak fileprivate var mobileNumber: UITextField!
    @IBOutlet weak fileprivate var sendersName: UITextField!
    @IBOutlet weak fileprivate var message: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: OpeningViewModel!
    fileprivate var reuseIdentifier = "cell"
    var textedNumbers = [TextedNumber]()
    
    private var textedRecipt = [Message]() {
        willSet {
            var alertMessage: AlertMessage
            alertMessage.message = viewModel.textedReceipt().message
            alertMessage.title = viewModel.textedReceipt().title
            Alert.showAlert(on: self, with: alertMessage.title, message: alertMessage.message)
        } 
        didSet {
            self.textedRecipt.removeAll()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelSetup()
        collectionViewSetUp()
        
    }

    private func viewModelSetup() {
        let dataSource = HTTPRequest()
        viewModel = OpeningViewModel(dataSourse: dataSource)
        viewModel.delegate = self
        
    }
    
    private func collectionViewSetUp() {
        self.textedNumbers = viewModel.loadData()
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
 
    private func setTextDetails() -> TextDetails {
        var messageInfo: TextDetails
        messageInfo.message = viewModel.prepareStringForURL(string: self.message.text ?? "")
        messageInfo.textNumber = viewModel.prepareNumberForUrl(number: self.mobileNumber.text ?? "")
        messageInfo.userName = viewModel.prepareStringForURL(string: self.sendersName.text ?? "")
        return messageInfo
    }
    
    
    @IBAction private func sendMessage(_ sender: Any) {
        if self.mobileNumber.text?.count != 11 || self.sendersName.text?.count ?? 0 > 10 {
            Alert.showAlert(on: self, with: "Error", message: "Please check the textfields.")
        } else {
            let textDetails = setTextDetails()
            viewModel.sendText(messageDetails: textDetails)
            viewModel.save(data: textDetails.textNumber)
            
            let textedNumber = TextedNumber(context: SaveData.context)
            textedNumber.phoneNumber = textDetails.textNumber
            textedNumber.date = viewModel.getCurrentDate()
            textedNumber.time = viewModel.getCurrentTime()
        }
    }
    
}

extension OpeningViewController: ViewModelDelegate {
    func modelDidUpdateData() {
        self.collectionView.reloadData()

        if viewModel.messageDetail.count == 1 {
            self.textedRecipt = viewModel.messageDetail
        }
    }

    func modelDidUpdateDataWithError(error: Error) {
        print(error)
    }
}

extension OpeningViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textedNumbers.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.mobileNumber.text = textedNumbers[indexPath.row].phoneNumber
        cell.dateTexted.text = textedNumbers[indexPath.row].date
        cell.timeTexted.text = textedNumbers[indexPath.row].time
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.bounds.size.height
        let width = view.bounds.size.width
        
        return CGSize (width: width - 20, height: height - 600)
    }
    
}
