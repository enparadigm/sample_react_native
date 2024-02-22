//
//  SharpsellCoreSwift.swift
//  SampleReact
//
//  Created by soham pandya on 20/02/24.
//

import Foundation
import SharpsellCore

@objc(SharpsellCoreSwift)
class SharpsellCoreSwift : NSObject {
  
  @objc static func requiresMainQueueSetup() -> Bool {
      return false
  }
  @objc func openPresentationTapped(_ sender: UIButton){}
  
  @objc func logoutSharpsell() -> Void {
    Sharpsell.services.clearData {
      // call back
      // Navigate back to your parent screen
//      let presentedViewController = RCTPresentedViewController();
//      presentedViewController?.navigationController?.popViewController(animated: true);
    } onFailure: { message, errorType in
      print("Logut Failed")
    }
  }
  @objc func createEngine() -> Void {
    DispatchQueue.main.async {
      Sharpsell.services.createFlutterEngine()
    }
  }
  
  @objc func initialiseEngine(_ options: NSDictionary) -> Void {
    
    
    DispatchQueue.main.async {
   //   Sharpsell.services.createFlutterEngine()
    //  let initSharpsellData: [String:Any] =  options as! [String : Any] //Only pass the user_details key if you want to update user fields
      var items = [String]()
      let companyCode:String = RCTConvert.nsString(options["company_code"])
      let userUniqueId:String = RCTConvert.nsString(options["user_unique_id"])
      let sharpsellApiKey:String = RCTConvert.nsString(options["sharpsell_api_key"])
      let fcmToken:String = RCTConvert.nsString(options["fcm_token"])

      
      let initSharpsellData: [String:Any] = [
          "company_code":companyCode,
          "user_unique_id":  userUniqueId,
          "sharpsell_api_key": sharpsellApiKey,
          "fcm_token": fcmToken]
    

              Sharpsell.services.initialize(smartsellParameters: initSharpsellData) {
                Sharpsell.services.open(arguments: ""){ (flutterViewController) in
                  
                  
                  Sharpsell.services.getTopMostViewController { topMostViewController in
                                      if topMostViewController is UINavigationController{
                                          let topVC = topMostViewController as! UINavigationController
                                          topVC.pushViewController(flutterViewController, animated: true)
                                      } else {
                                        flutterViewController.modalPresentationStyle = .fullScreen
                                          topMostViewController.present(flutterViewController, animated: true, completion: nil)
                                      }
                                  } onFailure: {
                                      NSLog("Sharpsell Parent App - Failed to get top most view controller")
                                  }
                  
                  
                  
                  
//                  let controller = RCTPresentedViewController();
////                  controller?.modalPresentationStyle = .fullScreen
//                  flutterViewController.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.openPresentationTapped))
//                  
//                  flutterViewController.modalPresentationStyle = .overFullScreen
//                  controller?.present(flutterViewController, animated: true)
                       } 
                onFailure: { (errorMessage, smartSellError) in
                           switch smartSellError {
                           case .flutterError:
                               debugPrint("Error Message: \(errorMessage)")
                           case .flutterMethodNotImplemented:
                               debugPrint("")
                           default:
                               debugPrint("")
                           }
                       }
                  //Flutter initialized succecfully
              } onFailure: { (errorMessage, smartsellError) in
                  switch smartsellError {
                  case .flutterError:
                      debugPrint("Error Message: \(errorMessage)")
                  case .flutterMethodNotImplemented:
                      debugPrint("Error Message: Flutter Method Not Implemented")
                  default:
                      debugPrint("Error Message: UnKnown Error in \(#function)")
                  }
              }
     // self._open(options: ["message":"initialised"]);
    }

  }
  // Reference to use main thread
  @objc func open(_ options: NSDictionary) -> Void {
    DispatchQueue.main.async {
      self._open(options: options)
    }
  }

  func _open(options: NSDictionary) -> Void {
    var items = [String]()
    let message = RCTConvert.nsString(options["message"])

    if message != "" {
      items.append(message!)
    }

    if items.count == 0 {
      print("No `message` to share!")
      return
    }

    let controller = RCTPresentedViewController();
    let shareController = UIActivityViewController(activityItems: items, applicationActivities: nil);

    shareController.popoverPresentationController?.sourceView = controller?.view;

    controller?.present(shareController, animated: true, completion: nil)
  }
}
