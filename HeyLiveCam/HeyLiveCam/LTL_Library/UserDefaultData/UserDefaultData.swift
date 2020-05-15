//
//  UserDefaultData.swift
//  HeyLiveCam
//
//  Created by Shree on 25/12/19.
//  Copyright © 2019 Shree. All rights reserved.
//

import UIKit

//MARK: - UserDefaultsKeys
enum UserDefaultsKeys : String {
    case isFirstTimeLoadApp
    case userID
    case settingCaptureAudioWithVideo
    case settingKeepScreenAwake
    case settingStoreGeolocationOnMedia
    case settingStartRecordingVideo
    case settingStopRecordingVideo
    case settingTakePhoto
    case settingTakeLivePhoto
    case settingReverseCamera
    case settingCloseHeyCamera
    case settingCameraSoundEffects
    case settingVideoResolution
    case settingTrimTheEndOfVideos
    case settingLanguageStatus
    case cameraTimerStatus
    case cameraFlashStatus
}

extension UserDefaults {

    //MARK: First Time Load App
    func setFirstTimeLoadApp(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isFirstTimeLoadApp.rawValue)
        synchronize()
    }

    func isFirstTimeLoadApp()-> Bool {
        return bool(forKey: UserDefaultsKeys.isFirstTimeLoadApp.rawValue)
    }

    //MARK: Setting Capture Audio With Videos
    func setSettingCaptureAudioWithVideo(value: Bool) {
        set(value, forKey: UserDefaultsKeys.settingCaptureAudioWithVideo.rawValue)
        synchronize()
    }
    func isSettingCaptureAudioWithVideo()-> Bool {
        return bool(forKey: UserDefaultsKeys.settingCaptureAudioWithVideo.rawValue)
    }
    
    //MARK: Keep Screen Awake
    func setSettingKeepScreenAwake(value: Bool) {
        set(value, forKey: UserDefaultsKeys.settingKeepScreenAwake.rawValue)
        synchronize()
    }
    func isSettingKeepScreenAwake()-> Bool {
        return bool(forKey: UserDefaultsKeys.settingKeepScreenAwake.rawValue)
    }
    
    //MARK: Store Geolocation On Media
    func setSettingStoreGeolocationOnMedia(value: Bool) {
        set(value, forKey: UserDefaultsKeys.settingStoreGeolocationOnMedia.rawValue)
        synchronize()
    }
    func isSettingStoreGeolocationOnMedia()-> Bool {
        return bool(forKey: UserDefaultsKeys.settingStoreGeolocationOnMedia.rawValue)
    }
    
    //MARK: - Start Recording Video
    func setSettingStartRecordingVideo(value: String) {
        set(value, forKey: UserDefaultsKeys.settingStartRecordingVideo.rawValue)
        synchronize()
    }
    func getSettingStartRecordingVideo()-> String {
        return string(forKey: UserDefaultsKeys.settingStartRecordingVideo.rawValue) ?? ""
    }
    
    //MARK: - Stop Recording Video
    func setSettingStopRecordingVideo(value: String) {
        set(value, forKey: UserDefaultsKeys.settingStopRecordingVideo.rawValue)
        synchronize()
    }
    func getSettingStopRecordingVideo()-> String {
        return string(forKey: UserDefaultsKeys.settingStopRecordingVideo.rawValue) ?? ""
    }
    
    //MARK: - Take Photo
    func setSettingTakePhoto(value: String) {
        set(value, forKey: UserDefaultsKeys.settingTakePhoto.rawValue)
        synchronize()
    }
    func getSettingTakePhoto()-> String {
        return string(forKey: UserDefaultsKeys.settingTakePhoto.rawValue) ?? ""
    }
    
    //MARK: - Take Live Photo
    func setSettingTakeLivePhoto(value: String) {
        set(value, forKey: UserDefaultsKeys.settingTakeLivePhoto.rawValue)
        synchronize()
    }
    func getSettingTakeLivePhoto()-> String {
        return string(forKey: UserDefaultsKeys.settingTakeLivePhoto.rawValue) ?? ""
    }
    
    //MARK: - Reverse Camera
    func setSettingReverseCamera(value: String) {
        set(value, forKey: UserDefaultsKeys.settingReverseCamera.rawValue)
        synchronize()
    }
    func getSettingReverseCamera()-> String {
        return string(forKey: UserDefaultsKeys.settingReverseCamera.rawValue) ?? ""
    }
    
    //MARK: - Close Hey Camera
    func setSettingCloseHeyCamera(value: String) {
        set(value, forKey: UserDefaultsKeys.settingCloseHeyCamera.rawValue)
        synchronize()
    }
    func getSettingCloseHeyCamera()-> String {
        return string(forKey: UserDefaultsKeys.settingCloseHeyCamera.rawValue) ?? ""
    }
    
    //MARK: Camera Sound Effect
    func setSettingCameraSoundEffect(value: Bool) {
        set(value, forKey: UserDefaultsKeys.settingCameraSoundEffects.rawValue)
        synchronize()
    }
    func isSettingCameraSoundEffect()-> Bool {
        return bool(forKey: UserDefaultsKeys.settingCameraSoundEffects.rawValue)
    }
    
    //MARK: Setting Video Resolution
    func setSettingVideoResolution(value: Bool) {
        set(value, forKey: UserDefaultsKeys.settingVideoResolution.rawValue)
        synchronize()
    }
    func isSettingVideoResolution()-> Bool {
        return bool(forKey: UserDefaultsKeys.settingVideoResolution.rawValue)
    }
    
    //MARK: - Setting Trim The End Of Videos
    func setSettingTrimTheEndOfVideos(value: Int) {
        set(value, forKey: UserDefaultsKeys.settingTrimTheEndOfVideos.rawValue)
        synchronize()
    }
    func getSettingTrimTheEndOfVideos()-> Int {
        return integer(forKey: UserDefaultsKeys.settingTrimTheEndOfVideos.rawValue)
    }
    
    //MARK: - Setting Trim The End Of Videos
    func setSettingLanguageStatus(value: Int) {
        set(value, forKey: UserDefaultsKeys.settingLanguageStatus.rawValue)
        synchronize()
    }
    func getSettingLanguageStatus()-> Int {
        return integer(forKey: UserDefaultsKeys.settingLanguageStatus.rawValue)
    }
    
    //MARK: - Set Camera Timer Status
    func setCameraTimerStatus(value: Int) {
        set(value, forKey: UserDefaultsKeys.cameraTimerStatus.rawValue)
        synchronize()
    }
    func getCameraTimerStatus()-> Int {
        return integer(forKey: UserDefaultsKeys.cameraTimerStatus.rawValue)
    }
    //MARK: - Set Camera Flash Status
    func setCameraFlashStatus(value: Int) {
        set(value, forKey: UserDefaultsKeys.cameraFlashStatus.rawValue)
        synchronize()
    }
    func getCameraFlashStatus()-> Int {
        return integer(forKey: UserDefaultsKeys.cameraFlashStatus.rawValue)
    }
}
