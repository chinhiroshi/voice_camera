//
//  ConstantFile.swift
//  HeyLiveCam
//
//  Created by Shree on 31/12/19.
//  Copyright © 2019 Shree. All rights reserved.
//

import UIKit

let strAppName = "Hey Live Cam"
let strAppPackageName = "com.ltl.HeyLiveCam"
let strSendFeedBackMailID = "pankajbhuva002@gmail.com"
let strSendFeedBackMailSubject = "Hey Live Cam v1.0"
let strRateAppUrl = "itms-apps://itunes.apple.com/app/id1442764573"

//MARK: - Camera Control Static
enum CameraControlStatic: String {
    case video
    case stop
    case photo
    case direction
    case closeCamera

    var rawValue: String {
        switch self {
            case .video: return "VIDEO"
            case .stop: return "STOP"
            case .photo: return "PHOTO"
            case .direction: return "DIRECTION"
            case .closeCamera: return "CLOSE"
        }
    }
}
