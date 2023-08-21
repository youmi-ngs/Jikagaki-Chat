//
//  PlusViewController.swift
//  Jikagaki
//
//  Created by Youmi Nagase on 2023/08/21.
//

import UIKit
import CoreNFC
class PlusViewController: UIViewController {
class PlusViewController: UIViewController, NFCNDEFReaderSessionDelegate {
        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
            
        }
        
        func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
            <#code#>
        }
        
        var NFC_session: NFCNDEFReaderSession?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            func NFCReadButtonPressed(_ sender: UIButton) {
                //NFC読み取り対象機種か確認
                guard NFCNDEFReaderSession.readingAvailable else {
                    let alertController = UIAlertController(
                        title: "Error",
                        message: "本端末はMFCに対応していません",
                        preferredStyle: .alert
                    )
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                //NFC読み取り用のインスタンス取得＋delegateにセット
                NFC_session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
                if let session = NFC_session{
                    session.alertMessage = "スキャン中"
                    //beginで読み取り画面が開く
                    session.begin()
                }
            }
        }
        
        
    }
    
}
