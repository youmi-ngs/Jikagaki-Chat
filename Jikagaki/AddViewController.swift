
import UIKit
import CoreNFC

class AddViewController: UIViewController,
    NFCNDEFReaderSessionDelegate {
        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
            print("error:\(error.localizedDescription)")
        }
        //データ読み込みに成功した場合に呼ばれる
        func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
            print("messages:\(messages.debugDescription)")
            
            DispatchQueue.main.async {
                Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { timer in
                    //NFC読み取りの表示を消す
                    session.invalidate()
                }
            }
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
        if let record = messages.first?.records.first{
                  switch record.typeNameFormat{
                  case .absoluteURI:
                      print("absoluteURI")
                      break
                  case .empty:
                      print("empty")
                      break
                  case .media:
                      print("media")
                      break
                  case .nfcExternal:
                      print("nfcExternal")
                      break
                  case .nfcWellKnown:
                      print("nfcWellKnown")
                      //読み込んだデータがURLだった場合
                      if let url = record.wellKnownTypeURIPayload(){
                          print(url)
                          let ac = UIAlertController(title: "NFC読み取り結果：URL", message: "\((url.description))", preferredStyle: .alert)
                          //アラートを閉じる
                          ac.addAction(UIAlertAction(title: "OK", style: .default,handler: { _ in
                              
                          }))
                          //NFCで取得したURLでSafariを開く
                          ac.addAction(UIAlertAction(title: "Webで開く", style: .default,handler: { _ in
                              UIApplication.shared.open(url)
                          }))
                          DispatchQueue.main.async {
                              self.present(ac, animated: true)
                              
                          }
                      }
                      
                      //読み込んだデータがテキストの場合
                      if let text0 = record.wellKnownTypeTextPayload().0,let text1 = record.wellKnownTypeTextPayload().1{
                          //アラートで表示、text0にはString、text1にはLocaleが入る
                          let ac = UIAlertController(title: "NFC読み取り結果：Text", message: "テキスト：\(text0)\n location:\(text1)", preferredStyle: .alert)
                          ac.addAction(UIAlertAction(title: "OK", style: .default ))
                          DispatchQueue.main.async {
                              self.present(ac, animated: true)
                          }
                      }
                      
                      break
                  case .unchanged:
                      print("unchanged")
                      break
                  case .unknown:
                      print("unknown")
                      break
                  default:
                      break
                  }
                  
              }else{
                  print("noMessage")
              }
          }
      }

            
            

        
    

