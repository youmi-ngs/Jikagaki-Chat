
import UIKit
import CoreNFC

class AddViewController: UIViewController, NFCNDEFReaderSessionDelegate{
    
        var NFC_session: NFCNDEFReaderSession?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            func NFCReadButtonPressed(_ sender: UIButton) {
                //NFC読み取り対象機種か確認
                guard NFCNDEFReaderSession.readingAvailable else {
                    let alertController = UIAlertController(
                        title: "Error",
                        message: "本端末はNFCに対応していません",
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
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        <#code#>
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        <#code#>
    }
        
        
}
    

