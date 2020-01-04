//
//  ViewController.swift
//  HeyLiveCam
//
//  Created by Shree on 19/12/19.
//  Copyright © 2019 Shree. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Foundation
import Speech
import AVKit
import IntentsUI
import Intents

//MARK: - Camera View Controller
class CameraVC: UIViewController {

    //TODO: - Outlet Declaration
    @IBOutlet var viewVideoCaptureBG: UIView!
    @IBOutlet var viewPhotoCaptureBG: UIView!
    @IBOutlet var btnPhoto: UIButton!
    @IBOutlet var btnVideo: UIButton!
    @IBOutlet var viewBlurBG: UIView!
    
    @IBOutlet var controlCameraBG: UIControl!
    @IBOutlet var viewCameraTransperant: UIView!
    @IBOutlet var widthConstraintCameraTransperent: NSLayoutConstraint!
    @IBOutlet var heightConstraintCameraTransperent: NSLayoutConstraint!
    
    @IBOutlet var imgNightMode: UIImageView!
    @IBOutlet var imgCameraFlash: UIImageView!
    @IBOutlet var imgCameraTimer: UIImageView!
    @IBOutlet var lblCameraTimer: UILabel!
    
    @IBOutlet var controlPhotoGallery: UIControl!
    @IBOutlet var imgPhotoGallery: UIImageView!
    
    //TODO: - Variable Declaration
    
    //Photo capture
    var imagesCaptured = [UIImage]()
    var captureSessionPhoto: AVCaptureSession!
    var cameraOutputPhoto: AVCapturePhotoOutput!
    var previewLayerPhoto: AVCaptureVideoPreviewLayer!
    
    //Video Capture
    var isPhotoCameraDisplay = true
    let captureSession = AVCaptureSession()
    let movieOutput = AVCaptureMovieFileOutput()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var activeInput: AVCaptureDeviceInput!
    var outputURL: URL!
    var isStartVideo = false
    
    var arrFlashModeList = [ModelPopupOver]()
    var arrTimerList = [ModelPopupOver]()
    var isNightMode = false
    var cameraFlashModeIndex = 2
    var cameraTimerIndex = 0
    var timerCameraAuto:Timer!
    var timerPlayVideo:Timer!
    var timerStopVideo:Timer!
    var isRearCamera = true
    
    var strStartRecordingVideo = ""
    var strStopRecordingVideo = ""
    var strTakePhoto = ""
    var strReverseCamera = ""
    var strCloseHeyCamera = ""
    
    //Speech to text
    var strSpeechText = ""
    var strSpeechTextParssed = ""
    var timerSpeechToText:Timer!
    
    let speechRecognizer        = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    var recognitionRequest      : SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask         : SFSpeechRecognitionTask?
    var audioEngine             = AVAudioEngine()
    
    //TODO: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialization
        self.initialization()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Change statusbar color
        UIApplication.shared.statusBarStyle = .default
        
        //Add Observers
        self.addObservers()
        
        //Setup Speech
        self.setupSpeech()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.strStartRecordingVideo = UserDefaults.standard.getSettingStartRecordingVideo()
        self.strStopRecordingVideo = UserDefaults.standard.getSettingStopRecordingVideo()
        self.strTakePhoto = UserDefaults.standard.getSettingTakePhoto()
        self.strReverseCamera = UserDefaults.standard.getSettingReverseCamera()
        self.strCloseHeyCamera = UserDefaults.standard.getSettingCloseHeyCamera()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if(self.timerCameraAuto != nil) {
            self.timerCameraAuto.invalidate()
        }
        
        //Stop Recording
        self.stopRecording()
        
        //Remove Observers
        self.removeObservers()
    }
    func initialization() {
        
        //Hide Blur View
        self.hideBlurView(isAnimated: true)
        
        self.controlCameraBG.layer.borderWidth = 1
        self.controlCameraBG.layer.borderColor = UIColor.white.cgColor
        self.controlCameraBG.layer.cornerRadius = 34
        
        //Flash Mode
        arrFlashModeList.append(ModelPopupOver.init(isSelected: false, title: "Auto", id: "0", isSelectionTouch: true))
        arrFlashModeList.append(ModelPopupOver.init(isSelected: false, title: "On", id: "1", isSelectionTouch: true))
        arrFlashModeList.append(ModelPopupOver.init(isSelected: true, title: "Off", id: "2", isSelectionTouch: true))
        
        //Timer Mode
        arrTimerList.append(ModelPopupOver.init(isSelected: true, title: "Off", id: "0", isSelectionTouch: true))
        arrTimerList.append(ModelPopupOver.init(isSelected: false, title: "3s", id: "1", isSelectionTouch: true))
        arrTimerList.append(ModelPopupOver.init(isSelected: false, title: "10s", id: "2", isSelectionTouch: true))
        
        //Hide Photo Gallery Button
        self.controlPhotoGallery.isHidden = true
        self.lblCameraTimer.text = ""
        
        //Update Camera Button
        self.updateCameraButton(type: 1, isAnimated: true)
        
    }
    func cameraTappedAnimation(isAnimated:Bool) {
        print("cameraTappedAnimation")
        //Tapped Event
        UIView.animate(withDuration: 0.1,
        animations: {
            self.viewCameraTransperant.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.view.layoutIfNeeded()
        },
        completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.viewCameraTransperant.transform = CGAffineTransform.identity
            }
        })
    }
    func updateCameraButton(type:Int,isAnimated:Bool) {
        
        if type == 1 {
            print("AAAAA")
            self.viewCameraTransperant.layer.cornerRadius = 25
            self.widthConstraintCameraTransperent.constant = 50
            self.heightConstraintCameraTransperent.constant = 50
            self.viewCameraTransperant.backgroundColor = .white
            
        } else if type == 2 {
            print("BBBBB")
            self.viewCameraTransperant.layer.cornerRadius = 25
            self.widthConstraintCameraTransperent.constant = 50
            self.heightConstraintCameraTransperent.constant = 50
            self.viewCameraTransperant.backgroundColor = .red
            
        } else if type == 3 {
            print("CCCCC")
            self.viewCameraTransperant.layer.cornerRadius = 7
            self.widthConstraintCameraTransperent.constant = 30
            self.heightConstraintCameraTransperent.constant = 30
            self.viewCameraTransperant.backgroundColor = .red
        }
    }
    func showBlurView(isAnimated:Bool) {
        
        self.viewBlurBG.isHidden = false
        if isAnimated == true {
            self.viewBlurBG.alpha = 0.01
            
            UIView.animate(withDuration: 0.1, animations: {
                self.viewBlurBG.alpha = 0.5
            }) { (isComplete) in
                self.hideBlurView(isAnimated: true)
            }
            
        } else {
            self.viewBlurBG.alpha = 1.0
        }
    }
    func hideBlurView(isAnimated:Bool) {
        
        if isAnimated == true {
            UIView.animate(withDuration: 0.1, animations: {
                self.viewBlurBG.alpha = 0.01
            }) { (isComplete) in
                self.viewBlurBG.isHidden = true
            }
        } else {
            self.viewBlurBG.isHidden = true
        }
    }
    
    func updateButtons() {
        
        if(self.isPhotoCameraDisplay) {
            //btnPhoto.isUserInteractionEnabled = true
            //btnVideo.isUserInteractionEnabled = false
            
            btnPhoto.backgroundColor = UIColor.init(red: 30/255, green: 25/255, blue: 22/255, alpha: 1.0)
            btnPhoto.setTitleColor(UIColor.init(red: 254/255, green: 96/255, blue: 32/255, alpha: 1), for: .normal)
            btnVideo.backgroundColor = UIColor.clear
            btnVideo.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
            
            viewPhotoCaptureBG.isHidden = false
            viewVideoCaptureBG.isHidden = true
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                //Start Photo Camera
                self.startPhotoCamera()
            }
            
            //Update Camera Button
            self.updateCameraButton(type: 1, isAnimated: true)
            
        } else {
            //btnPhoto.isUserInteractionEnabled = false
            //btnVideo.isUserInteractionEnabled = true
            
            btnVideo.backgroundColor = UIColor.init(red: 30/255, green: 25/255, blue: 22/255, alpha: 1.0)
            btnVideo.setTitleColor(UIColor.init(red: 254/255, green: 96/255, blue: 32/255, alpha: 1), for: .normal)
            btnPhoto.backgroundColor = UIColor.clear
            btnPhoto.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
            
            viewPhotoCaptureBG.isHidden = true
            viewVideoCaptureBG.isHidden = false
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                if setupSession() {
                    setupPreview()
                    startSession()
                }
            }
            
            //Update Camera Button
            self.updateCameraButton(type: 2, isAnimated: true)
        }
    }
    func changeCameraNightMode() {
        if isNightMode == true {
            imgNightMode.image = UIImage.init(named: "imgCameraNightModeOn")
        } else {
            imgNightMode.image = UIImage.init(named: "imgCameraNightModeOff")
        }
    }
}
//MARK: - Setup Speech
extension CameraVC {
    @objc func setupSpeech() {

        self.speechRecognizer?.delegate = self

        SFSpeechRecognizer.requestAuthorization { (authStatus) in

            var isButtonEnabled = false

            switch authStatus {
            case .authorized:
                isButtonEnabled = true

            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")

            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")

            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }

            OperationQueue.main.addOperation() {
                //self.btnStart.isEnabled = isButtonEnabled
                if(isButtonEnabled == true) {
                    //Start Speech Recording
                    self.startSpeechRecording()
                }
            }
        }
    }
    func startSpeechRecording() {

        // Clear all previous session data and cancel task
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }

        // Create instance of audio session to record voice
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record, mode: AVAudioSession.Mode.measurement, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }

        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        audioEngine = AVAudioEngine()
        let inputNode = audioEngine.inputNode

        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }

        recognitionRequest.shouldReportPartialResults = true
        
        self.recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in

            var isFinal = false

            if result != nil {
                /*if(result?.transcriptions.count ?? 0>0) {
                    let finalTranscriptions = result?.transcriptions[(result?.transcriptions.count ?? 0)-1]
                    var strSpeechWord = finalTranscriptions?.formattedString
                    strSpeechWord = strSpeechWord?.uppercased()
                    
                    let parsed = strSpeechWord?.replacingOccurrences(of: self.strSpeechText, with: "")
                    
                    self.strSpeechText = strSpeechWord ?? ""
                    print("Final Word : ",strSpeechWord)
                    print("Final Word parsed : ",parsed)
                } else {
                    
                }*/
                
                //self.txtViewDescription.text = result?.bestTranscription.formattedString
                var strSpeechWord = (result?.bestTranscription.formattedString ?? "") + ""
                strSpeechWord = strSpeechWord.uppercased()
                strSpeechWord = strSpeechWord.trimmingCharacters(in: .whitespaces)
                
                if(self.strSpeechText != strSpeechWord) {
                    let strParsed = strSpeechWord.replacingOccurrences(of: self.strSpeechText, with: "").trimmingCharacters(in: .whitespaces)
                    //strSpeechWord = strSpeechWord.uppercased()
                    self.strSpeechText = strSpeechWord
                    self.strSpeechTextParssed = strParsed
                    
                    print("SPEECH WORD PARSED :",strParsed)
                    print("SPEECH WORD :",strSpeechWord)
                    
                    if(self.timerSpeechToText != nil) {
                        self.timerSpeechToText.invalidate()
                    }
                    self.timerSpeechToText = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.checkSpokeWord), userInfo: nil, repeats: false)
                }
                isFinal = (result?.isFinal)!
            }

            //if error != nil || isFinal {

                //self.audioEngine.stop()
                //inputNode.removeTap(onBus: 0)

                //self.recognitionRequest = nil
                //self.recognitionTask = nil

                //self.btnStart.isEnabled = true
            //}
        })

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        self.audioEngine.prepare()

        do {
            try self.audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }

        print("Say something, I'm listening!")
    }
    @objc func checkSpokeWord() {
        print("Check Spoke Word")
        
        print("SPEECH TEXT PARSSED :",self.strSpeechTextParssed)
        
        /*var strStartRecordingVideo = ""
        var strStopRecordingVideo = ""
        var strTakePhoto = ""
        var strReverseCamera = ""
        var strCloseHeyCamera = ""*/
        
        if(self.strSpeechTextParssed == self.strReverseCamera) {
            
            //Reverse Camera
            self.reverseCamera()
            
        } else if(self.strSpeechTextParssed == self.strTakePhoto) {
            
            //Photo Event
            self.photoEvent(isCapturePhoto: true)
            
        } else if(self.strSpeechTextParssed == self.strStartRecordingVideo) {
                   
            //Video Event
            self.videoEvent(isPlayVideo: true)
            
        } else if(self.strSpeechTextParssed == self.strStopRecordingVideo) {
            
            self.stopRecording()
            
        } else if(self.strSpeechTextParssed == self.strCloseHeyCamera) {
            
            //Close The App
            self.closeTheApp()
        }
    }
}
//MARK: - Background / Foreground Application
extension CameraVC {
    
    func addObservers() {
      NotificationCenter.default.addObserver(self,
                                             selector: #selector(applicationDidBecomeActive),
                                             name: UIApplication.didBecomeActiveNotification,
                                             object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
    }
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    @objc func applicationDidBecomeActive() {
        print("Application Did Become Active")
        
        //Update Buttons
        self.updateButtons()
    }
    @objc func applicationDidEnterBackground() {
        print("Application Did Enter Background")
        
        if(movieOutput.isRecording == true && self.isPhotoCameraDisplay == true) {
            
            //Stop Recording
            self.stopRecording()
            
            //Update Camera Button
            self.updateCameraButton(type: 2, isAnimated: true)
            
        }
    }
}
//MARK: - SFSpeechRecognizerDelegate
extension CameraVC: SFSpeechRecognizerDelegate {

    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        print("speechRecognizer : availabilityDidChange")
        if available {
            //self.btnStart.isEnabled = true
        } else {
            //self.btnStart.isEnabled = false
        }
    }
}
//MARK: - UIImagePickerControllerDelegate
extension CameraVC:UIImagePickerControllerDelegate {
    
}
//MARK: - AVCaptureFileOutputRecordingDelegate
extension CameraVC:AVCaptureFileOutputRecordingDelegate {
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {

    }

    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {

        if (error != nil) {

            print("Error recording movie: \(error!.localizedDescription)")

        } else {

            let videoRecorded = outputURL! as URL
            self.playVideo(from: videoRecorded.absoluteString)
            print("Video Recorded : ",videoRecorded.absoluteString)
            
            let imgThumbnail = self.createThumbnailOfVideoFromRemoteUrl(url: videoRecorded.absoluteString)
            if imgThumbnail != nil {
                self.controlPhotoGallery.isHidden = false
                self.imgPhotoGallery.image = imgThumbnail
            }
            
            PHPhotoLibrary.shared().performChanges({ () -> Void in

                let createAssetRequest: PHAssetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: NSURL(string: videoRecorded.absoluteString)! as URL)!
                createAssetRequest.placeholderForCreatedAsset

                }) { (success, error) -> Void in
                    if success {

                        //popup alert success
                    }
                    else {
                       //popup alert unsuccess
                    }
            }
        }
    }
    private func playVideo(from file:String) {
        let file = file.components(separatedBy: ".")
        guard let path = Bundle.main.path(forResource: file[0], ofType:file[1]) else {
            debugPrint( "\(file.joined(separator: ".")) not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage? {
        let asset = AVAsset(url: URL(string: url)!)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        //assetImgGenerate.maximumSize = CGSize(width,height)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
          print(error.localizedDescription)
          return nil
        }
    }
}
//MARK: - Video Function
extension CameraVC {
    func setupPreview() {
         // Configure previewLayer
         previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
         previewLayer.frame = viewVideoCaptureBG.bounds
         previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
         viewVideoCaptureBG.layer.addSublayer(previewLayer)
     }
     //MARK:- Setup Camera
     func setupSession() -> Bool {
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        // Setup Camera
        //let camera = AVCaptureDevice.default(for: AVMediaType.video)!
        
        var defaultVideoDevice = AVCaptureDevice.default(for: AVMediaType.video)!

        if(isRearCamera == true) {
            
            if let dualCameraDevice = AVCaptureDevice.default(.builtInDualCamera, for: AVMediaType.video, position: .back) {
                defaultVideoDevice = dualCameraDevice
            }

            else if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) {
                defaultVideoDevice = backCameraDevice
            }
            
        } else {
            
            if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front) {
                defaultVideoDevice = frontCameraDevice
            }
        }
        
        if defaultVideoDevice.hasFlash {
            //defaultVideoDevice.focusMode = .continuousAutoFocus
            if(cameraFlashModeIndex == 0) {
                //defaultVideoDevice.torchMode = .auto
            } else if(cameraFlashModeIndex == 1) {
                //defaultVideoDevice.torchMode = .on
            } else if(cameraFlashModeIndex == 2) {
                //defaultVideoDevice.torchMode = .off
            }
        }
        do {
            let input = try AVCaptureDeviceInput(device: defaultVideoDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
                activeInput = input
            }
        } catch {
            print("Error setting device video input: \(error)")
            return false
        }
        // Setup Microphone
        let microphone = AVCaptureDevice.default(for: AVMediaType.audio)!
        do {
            let micInput = try AVCaptureDeviceInput(device: microphone)
            if captureSession.canAddInput(micInput) {
                captureSession.addInput(micInput)
            }
        } catch {
            print("Error setting device audio input: \(error)")
            return false
        }
        // Movie output
        if captureSession.canAddOutput(movieOutput) {
            captureSession.addOutput(movieOutput)
        }
        return true
    }
    func setupCaptureMode(_ mode: Int) {
         // Video Mode
    }
    //MARK:- Camera Session
    func startSession() {
        if !captureSession.isRunning {
            videoQueue().async {
                self.captureSession.startRunning()
            }
        }
    }
    func stopSession() {
        if captureSession.isRunning {
            videoQueue().async {
                self.captureSession.stopRunning()
            }
        }
    }
    func videoQueue() -> DispatchQueue {
        return DispatchQueue.main
    }
    func currentVideoOrientation() -> AVCaptureVideoOrientation {
        var orientation: AVCaptureVideoOrientation
        /*switch UIDevice.current.orientation {
            case .portrait:
                orientation = AVCaptureVideoOrientation.portrait
            case .landscapeRight:
                orientation = AVCaptureVideoOrientation.landscapeLeft
            case .portraitUpsideDown:
                orientation = AVCaptureVideoOrientation.portraitUpsideDown
            default:
                orientation = AVCaptureVideoOrientation.landscapeRight
        }*/
        orientation = AVCaptureVideoOrientation.portrait
        return orientation
    }
    @objc func startCapture() {
        startRecording()
    }
    //EDIT 1: I FORGOT THIS AT FIRST
    func tempURL() -> URL? {
        let directory = NSTemporaryDirectory() as NSString
        if directory != "" {
            let path = directory.appendingPathComponent(NSUUID().uuidString + ".mp4")
            return URL(fileURLWithPath: path)
        }
        return nil
    }
    @objc func startRecording() {
        if movieOutput.isRecording == false {
            let connection = movieOutput.connection(with: AVMediaType.video)
            if (connection?.isVideoOrientationSupported)! {
                connection?.videoOrientation = currentVideoOrientation()
            }
            if (connection?.isVideoStabilizationSupported)! {
                connection?.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.auto
            }
            let device = activeInput.device
            if (device.isSmoothAutoFocusSupported) {
                do {
                    try device.lockForConfiguration()
                    device.isSmoothAutoFocusEnabled = false
                    device.unlockForConfiguration()
                } catch {
                    print("Error setting configuration: \(error)")
                }
            }
            //EDIT2: And I forgot this
            outputURL = tempURL()
            movieOutput.startRecording(to: outputURL, recordingDelegate: self)
            
            //Update Camera Button
            self.updateCameraButton(type: 3, isAnimated: true)
            
            //Start Speech Recording
            self.startSpeechRecording()
            
        } else {
            
            //Stop Recording
            self.stopRecording()
        }
    }
    @objc func stopRecording() {
        if movieOutput.isRecording == true {
            movieOutput.stopRecording()
            //Update Camera Button
            self.updateCameraButton(type: 2, isAnimated: true)
        }
    }
    @objc func capturePhoto() {
        
        self.showBlurView(isAnimated: true)
        
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            kCVPixelBufferWidthKey as String: 160,
            kCVPixelBufferHeightKey as String: 160
        ]
        settings.previewPhotoFormat = previewFormat
        cameraOutputPhoto.capturePhoto(with: settings, delegate: self)
    }
}
//MARK: - Photo Functions
extension CameraVC {
    
    func startPhotoCamera() {
        
        captureSessionPhoto = AVCaptureSession()
        captureSessionPhoto.sessionPreset = AVCaptureSession.Preset.photo
        cameraOutputPhoto = AVCapturePhotoOutput()
        cameraOutputPhoto.isHighResolutionCaptureEnabled = true
        cameraOutputPhoto.isLivePhotoCaptureEnabled = cameraOutputPhoto.isLivePhotoCaptureSupported
        
        //let device = AVCaptureDevice.default(for: AVMediaType.video)!
        var device = AVCaptureDevice.default(for: AVMediaType.video)!

        if(isRearCamera == true) {
            
            if let dualCameraDevice = AVCaptureDevice.default(.builtInDualCamera, for: AVMediaType.video, position: .back) {
                device = dualCameraDevice
            }

            else if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) {
                device = backCameraDevice
            }
            
        } else {
            
            if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front) {
                device = frontCameraDevice
            }
        }
        
        if device.hasFlash {
            //device.focusMode = .continuousAutoFocus
            if(cameraFlashModeIndex == 0) {
                //device.torchMode = .auto
            } else if(cameraFlashModeIndex == 1) {
                //device.torchMode = .on
            } else if(cameraFlashModeIndex == 2) {
                //device.torchMode = .off
            }
        }
        
        if let input = try? AVCaptureDeviceInput(device: device) {
            if (captureSessionPhoto.canAddInput(input)) {
                captureSessionPhoto.addInput(input)
                if (captureSessionPhoto.canAddOutput(cameraOutputPhoto)) {
                    captureSessionPhoto.sessionPreset = .photo
                    captureSessionPhoto.addOutput(cameraOutputPhoto)
                    previewLayerPhoto = AVCaptureVideoPreviewLayer(session: captureSessionPhoto)
                    previewLayerPhoto.videoGravity = .resizeAspectFill
                    previewLayerPhoto.frame = viewPhotoCaptureBG.bounds
                    previewLayerPhoto.backgroundColor = UIColor.white.cgColor
                    viewPhotoCaptureBG.layer.addSublayer(previewLayerPhoto)
                    captureSessionPhoto.startRunning()
                }
            } else {
                print("issue here : captureSesssion.canAddInput")
            }
        } else {
            print("some problem here")
        }
    }
    func reverseCamera() {
        
        self.isRearCamera = !self.isRearCamera
        
        if(self.isPhotoCameraDisplay) {
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                //Start Photo Camera
                self.startPhotoCamera()
            }
        } else {
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                if setupSession() {
                    setupPreview()
                    startSession()
                }
            }
        }
    }
    func photoEvent(isCapturePhoto:Bool) {
        
        if(self.isPhotoCameraDisplay) {
            
            if(isCapturePhoto == true) {
                //Capture Photo
                self.capturePhoto()
            }
        } else {
            
            //Update Buttons
            isPhotoCameraDisplay = true
            self.updateButtons()
            if(movieOutput.isRecording == true) {
                //Stop Recording
                self.stopRecording()
            }
            
            if(isCapturePhoto == true) {
                if(self.timerCameraAuto != nil) {
                    self.timerCameraAuto.invalidate()
                }
                self.timerCameraAuto = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(capturePhoto), userInfo: nil, repeats: false)
            }
        }
    }
    func videoEvent(isPlayVideo:Bool) {
        
        if(self.isPhotoCameraDisplay) {
            
            //Update Buttons
            isPhotoCameraDisplay = false
            self.updateButtons()
            
            //Camera Tapped Animation
            self.cameraTappedAnimation(isAnimated: isPlayVideo)
            
            if(isPlayVideo == true) {
                if(self.timerPlayVideo != nil) {
                    self.timerPlayVideo.invalidate()
                }
                self.timerPlayVideo = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startRecording), userInfo: nil, repeats: false)
            }
        } else {
          
            if(isPlayVideo == true) {
                //Start Recording
                self.startRecording()
            }
        }
    }
    func closeTheApp() {
        exit(0)
    }
}
//MARK: - Tapped Event
extension CameraVC {
    @IBAction func tappedOnPhotoAlbum(_ sender: Any) {
        print("Tapped On Photo Album")
        
        //Redirect To Photo Gallery
        self.redirectToPhotoGallery()
    }
    @IBAction func tappedOnTakePhoto(_ sender: Any) {
        
        //Photo Event
        self.photoEvent(isCapturePhoto: false)
    }
    @IBAction func tappedOnVideo(_ sender: Any) {
        print("Tapped On Video")
        
        //Video Event
        self.videoEvent(isPlayVideo: false)
    }
    @IBAction func tappedOnCamera(_ sender: Any) {
        
        //Camera Tapped Animation
        self.cameraTappedAnimation(isAnimated: true)
        
        if(self.isPhotoCameraDisplay) {
            
            if cameraTimerIndex == 0 {
                //Capture Photo
                self.capturePhoto()
                
            } else if cameraTimerIndex == 1 {
                if(self.timerCameraAuto != nil) {
                    self.timerCameraAuto.invalidate()
                }
                self.timerCameraAuto = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(capturePhoto), userInfo: nil, repeats: false)
                
            } else if cameraTimerIndex == 2 {
                if(self.timerCameraAuto != nil) {
                    self.timerCameraAuto.invalidate()
                }
                self.timerCameraAuto = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(capturePhoto), userInfo: nil, repeats: false)
            }
        } else {
            if(movieOutput.isRecording == true) {
                
                //Stop Recording
                self.stopRecording()
                
                //Update Camera Button
                self.updateCameraButton(type: 2, isAnimated: true)
                
            } else {
                
                //Start Recording
                self.startRecording()
                
                //Update Camera Button
                self.updateCameraButton(type: 3, isAnimated: true)
            }
        }
    }
    @IBAction func tappedOnReverseCamera(_ sender: Any) {
        
        //Reverse Camera
        self.reverseCamera()
    }
    @IBAction func tappedOnNightMode(_ sender: Any) {
        print("Tapped On Night Mode")
        
        self.isNightMode = !self.isNightMode
        
        //Change Camera Night Mode
        self.changeCameraNightMode()
    }
    @IBAction func tappedOnFlashMode(_ sender: Any) {
        print("Tapped On Flash Mode")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popOver = storyboard.instantiateViewController(withIdentifier: "PopOverVC") as! PopOverVC
        popOver.modalPresentationStyle = .popover
        popOver.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        popOver.popoverPresentationController?.sourceView = imgCameraFlash
        popOver.popoverPresentationController?.sourceRect = imgCameraFlash.bounds
        popOver.preferredContentSize = CGSize(width: 80, height: 50.0)
        popOver.delegate = self
        popOver.popupIndex = 1
        popOver.arrPopOverList.removeAll()
        popOver.arrPopOverList = arrFlashModeList
        popOver.popoverPresentationController?.delegate = self
        self.present(popOver, animated: true) {
            
        }
    }
    @IBAction func tappedOnTimer(_ sender: Any) {
        print("Tapped On Timer")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popOver = storyboard.instantiateViewController(withIdentifier: "PopOverVC") as! PopOverVC
        popOver.modalPresentationStyle = .popover
        popOver.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        popOver.popoverPresentationController?.sourceView = imgCameraTimer
        popOver.popoverPresentationController?.sourceRect = imgCameraTimer.bounds
        popOver.preferredContentSize = CGSize(width: 80, height: 50.0)
        popOver.delegate = self
        popOver.popupIndex = 2
        popOver.arrPopOverList.removeAll()
        popOver.arrPopOverList = arrTimerList
        popOver.popoverPresentationController?.delegate = self
        self.present(popOver, animated: true) {
            
        }
    }
    @IBAction func tappedOnSettings(_ sender: Any) {
        
        print("Tapped On Settings")
        
        //Redirect To Settings Screen
        self.redirectToSettingsScreen()
    }
}
//MARK: - AV Capture Photo Capture Delegate
extension CameraVC : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        if let error = error {
            print("error occured : \(error.localizedDescription)")
        }

        if let dataImage = photo.fileDataRepresentation() {
            print(UIImage(data: dataImage)?.size as Any)

            let dataProvider = CGDataProvider(data: dataImage as CFData)
            let cgImageRef: CGImage! = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
            let image = UIImage(cgImage: cgImageRef, scale: 1.0, orientation: UIImage.Orientation.right)

            /**
               save image in array / do whatever you want to do with the image here
            */
            let orientationFixedImage = image.fixOrientation()
            UIImageWriteToSavedPhotosAlbum(orientationFixedImage, nil, nil, nil);
            //self.imagesCaptured.append(orientationFixedImage)
            self.controlPhotoGallery.isHidden = false
            self.imgPhotoGallery.image = orientationFixedImage

        } else {
            print("some error here")
        }
    }
}
//MARK: - Redirect to next screen
extension CameraVC {
    func redirectToSettingsScreen() {
        let vcSettings = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(vcSettings, animated: true)
    }
    func redirectToInAppPurchaseScreen() {
        
        let vcInAppPurchase = self.storyboard?.instantiateViewController(withIdentifier: "InAppPurchaseVC") as! InAppPurchaseVC
        self.present(vcInAppPurchase, animated: true, completion: nil)
    }
    func redirectToPhotoGallery() {
        let localController = PhotosController(dataSourceType: .local)
        self.navigationController?.pushViewController(localController, animated: true)
    }
}
//MARK: - PopupOverDelegate
extension CameraVC: PopupOverDelegate {
    
    func getPopOverData(arrData:[ModelPopupOver],index:Int,tag:Int) {
        
        if tag == 1 {
            
            self.arrFlashModeList = arrData
            self.cameraFlashModeIndex = index
            
            if(index == 0) {
                imgCameraFlash.image = UIImage.init(named: "imgCameraFlashWhiteAuto")
                
            } else if(index == 1) {
                
                imgCameraFlash.image = UIImage.init(named: "imgCameraFlashWhiteOn")
                
            } else if(index == 2) {
                           
                imgCameraFlash.image = UIImage.init(named: "imgCameraFlashWhiteOff")
            }
            
        } else if(tag == 2) {
            
            self.arrTimerList = arrData
            self.cameraTimerIndex = index
            
            if(index == 0) {
                self.lblCameraTimer.text = ""
                
            } else if(index == 1) {
                
                self.lblCameraTimer.text = "3"
                
            } else if(index == 2) {
                           
                self.lblCameraTimer.text = "10"
            }
        }
    }
    func dismissPopoverView() {
        
    }
}
//MARK: - UIPopoverPresentationControllerDelegate
extension CameraVC: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
