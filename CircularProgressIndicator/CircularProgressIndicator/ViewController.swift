//
//  ViewController.swift
//  CircularProgressIndicator
//
//  Created by Jasmeet Kaur on 21/04/19.
//  Copyright © 2019 Jasmeet Kaur. All rights reserved.
//

import UIKit

class ViewController: UIViewController,URLSessionDownloadDelegate {
    
    
    let progressLayer = CAShapeLayer()
    let backgroundLayer = CAShapeLayer()
    let urlstring = "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4"
    let percentageLabel = UILabel()
    let pulseLayer = CAShapeLayer()
    
    
    fileprivate func createPercentageLabel() {
        self.percentageLabel.frame = CGRect(origin:CGPoint(x: 0, y: 0) , size: CGSize(width: 100, height: 100))
        self.percentageLabel.center = view.center
        self.percentageLabel.textColor = .white
        
        self.percentageLabel.textAlignment = .center
        self.percentageLabel.lineBreakMode = .byWordWrapping
        self.percentageLabel.numberOfLines = 2
        self.percentageLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 27)!
        self.percentageLabel.text = "Start"
        self.view.addSubview(percentageLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.view.backgroundColor = .black
        createPulseLayer()
        createBackgroundLayer()
        createPercentageLabel()
        createProgressLayer()
        
        
        
        downloadFile()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        DispatchQueue.main.async {
        self.percentageLabel.text = "100% Completed"
        print("Download completed")
        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        let percentage = CGFloat(totalBytesWritten)/CGFloat(totalBytesExpectedToWrite)
        print(percentage)
        
        DispatchQueue.main.async {
            self.progressLayer.strokeEnd = percentage
             self.percentageLabel.text = "\(Int(percentage*100))%"
        }
    }
    fileprivate func createProgressLayer() {
        // Do any additional setup after loading the view, typically from a nib.
        let center = self.view.center
        let progressLayerPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: true)
        progressLayer.path = progressLayerPath.cgPath
        progressLayer.strokeColor = UIColor(red: 46/255, green: 234255, blue: 111/255, alpha: 1).cgColor
        progressLayer.strokeEnd = 0
        progressLayer.lineWidth = 10.0
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = CAShapeLayerLineCap.round
        self.view.layer.addSublayer(progressLayer)
        
    }
    
    
    fileprivate func downloadFile(){
        
        
        let urlSessionConfiguration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlsession = URLSession(configuration: urlSessionConfiguration, delegate: self, delegateQueue: operationQueue)
        guard let url = URL(string: urlstring) else { return }
        let downloadTask = urlsession.downloadTask(with:url)
        downloadTask.resume()
        
        
    }
    
    fileprivate func createBackgroundLayer(){
        
        let greyLayerPath = UIBezierPath(arcCenter: self.view.center
            , radius: 100, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        backgroundLayer.path = greyLayerPath.cgPath
        backgroundLayer.strokeColor = UIColor(red: 25/255, green: 56/255, blue: 49/255, alpha: 1).cgColor
        backgroundLayer.lineWidth = 10.0
        backgroundLayer.fillColor = UIColor.black.cgColor
        
        self.view.layer.addSublayer(backgroundLayer)
        
        
    }
    
    fileprivate func createPulseLayer(){
        
        let pulseLayerPath = UIBezierPath(arcCenter: .zero
            , radius: 100, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        pulseLayer.path = pulseLayerPath.cgPath
        pulseLayer.strokeColor = UIColor.clear.cgColor
        pulseLayer.lineWidth = 10.0
        pulseLayer.position = self.view.center
        pulseLayer.fillColor = UIColor(red: 30/255, green: 86/255, blue: 63/255, alpha: 1).cgColor
       
        self.view.layer.addSublayer(pulseLayer)
         animatePulaseLayer()
        
    }
    
    func animatePulaseLayer(){
        let basicAnimation = CABasicAnimation(keyPath:"transform.scale")
        
                    basicAnimation.toValue = 1.5
        
                    basicAnimation.duration = CFTimeInterval(5)
                    basicAnimation.repeatCount = .infinity
                    basicAnimation.autoreverses = true
                pulseLayer.add(basicAnimation, forKey: "pulse")
        
    }
    
}

