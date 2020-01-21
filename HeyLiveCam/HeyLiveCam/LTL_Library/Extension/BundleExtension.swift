//
//  BundleExtension.swift
//  HeyLiveCam
//
//  Created by Shree on 18/01/20.
//  Copyright © 2020 Shree. All rights reserved.
//

import Foundation

extension Bundle {
    
    //Release Version Number
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    //Build Version Number
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    //Application Name
    var appName: String {
        return infoDictionary?["CFBundleName"] as! String
    }

    //Bundle Id
    var bundleId: String {
        return bundleIdentifier!
    }
}
