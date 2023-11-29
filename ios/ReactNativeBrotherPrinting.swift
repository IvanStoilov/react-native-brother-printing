import Foundation
import UIKit
import CoreImage
import UniformTypeIdentifiers
import BRLMPrinterKit

@objc(ReactNativeBrotherPrinting)
class ReactNativeBrotherPrinting: NSObject {
    
    @objc
    func printImageViaWifi(_ printURI: String, ipAddress ip: String, modelName model: String, cb callback: @escaping RCTResponseSenderBlock) -> Void {
        DispatchQueue.global().async {
            print("[ReactNativeBrotherPrinting] Wifi printing ", ip, model)
            let channel = BRLMChannel(wifiIPAddress: ip)
            self.printImage(channel, printURI, modelName: model, cb: callback)
        }
    }
    
    @objc
    func printImageViaBluetooth(_ printURI: String, modelName model: String, cb callback: @escaping RCTResponseSenderBlock) -> Void {
        DispatchQueue.global().async {
            print("[ReactNativeBrotherPrinting] Discovering printers")
            let searcher = BRLMPrinterSearcher.startBluetoothSearch();
            
            print("[ReactNativeBrotherPrinting] Bluetooth channels", searcher.channels.count, searcher.channels)
            
            if (searcher.error.code != .noError) {
                callback([searcher.error.code, "Error searching for printer"])
                return
            }
                        
            let optionalChannel = searcher.channels.first(where: {(channel: BRLMChannel) in
                channel.extraInfo?.value(forKey: BRLMChannelExtraInfoKeyModelName) as! String == model
            })
            
            if (optionalChannel == nil) {
                callback([101, "Printer not connected"])
                return
            }
            
            self.printImage(optionalChannel!, printURI, modelName: model, cb: callback)
        }
    }
    
    @objc
    func printImage(_ channel: BRLMChannel, _ printURI: String, modelName model: String, cb callback: @escaping RCTResponseSenderBlock) -> Void {
        let generateResult = BRLMPrinterDriverGenerator.open(channel)
        guard generateResult.error.code == BRLMOpenChannelErrorCode.noError,
            let printerDriver = generateResult.driver else {
                print("[ReactNativeBrotherPrinting] Error - Open Channel: \(generateResult.error.code)")
                callback([generateResult.error.code, "Error opening the printer"])
                return
        }
        defer {
            printerDriver.closeChannel()
        }
                    
        let printerStatus = printerDriver.getPrinterStatus()
        
        if (printerStatus.error.code != .noError) {
            print("[ReactNativeBrotherPrinting] Printer status cannot be fetched")
            callback([printerStatus.error.code, "Error fetching printer status"])
            return
        }
        
        let pStatus = printerStatus.status!;
        
        var fetchedLabelSize = true;
        
        let printSettings = BRLMQLPrintSettings(defaultPrintSettingsWith: pStatus.model)
        
        if (printSettings == nil) {
            print("[ReactNativeBrotherPrinting] Unable to initalize print settings")
            callback([104, "Error initializing print settings"])
            return
        }
        let pSettings = printSettings!;
        
        let labelSize = pStatus.mediaInfo?.getQLLabelSize(&fetchedLabelSize)
        
        if (!fetchedLabelSize && labelSize != nil) {
            print("[ReactNativeBrotherPrinting] Error fetching label size")
            callback([103, "Error fetching label size"])
            return
        }
                  
        pSettings.autoCut = true
        pSettings.labelSize = labelSize!
        
        let url = URL(fileURLWithPath: printURI);
        let printError = printerDriver.printImage(with: url, settings: pSettings)
        
        if (printError.code != .noError) {
            print("[ReactNativeBrotherPrinting] Error printing", printError.code)
            callback([printError.code])
            return
        }
        
        callback([0])
    }
    
    @objc
    static func requiresMainQueueSetup() -> Bool {
      return true
    }
 
}
