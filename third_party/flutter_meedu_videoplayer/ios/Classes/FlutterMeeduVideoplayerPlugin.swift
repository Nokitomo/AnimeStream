import Flutter
import UIKit
import AVKit

public class FlutterMeeduVideoplayerPlugin: NSObject, FlutterPlugin, AVPictureInPictureControllerDelegate {
    
    private var channel: FlutterMethodChannel
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_meedu_videoplayer", binaryMessenger: registrar.messenger())
        let instance = FlutterMeeduVideoplayerPlugin(channel)
        registrar.addMethodCallDelegate(instance, channel: channel);
    }
    
    init(_ channel: FlutterMethodChannel) {
        self.channel = channel
        super.init()
    }
  
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            
        case "isPipAvailable":
            result(isPipAvailable())
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func isPipAvailable() -> Bool {
        if #available(iOS 14.0, *) {
            return AVPictureInPictureController.isPictureInPictureSupported()
        } else {
            return false
        }
    }
}