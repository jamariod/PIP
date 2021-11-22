//
//  ViewController.swift
//  PIP
//
//  Created by Jamario Davis on 11/21/21.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController, AVPlayerViewControllerDelegate {
   
    
    var playerController: AVPlayerViewController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    @IBAction func play(_ sender: Any) {
        let path = Bundle.main.path(forResource: "Beach", ofType: "mp4")!
                let url = NSURL(fileURLWithPath: path)
                let player = AVPlayer(url: url as URL)
                playerController = AVPlayerViewController()
                NotificationCenter.default.addObserver(self, selector: #selector(ViewController.didfinishPlaying(note:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
                playerController.player = player
                playerController.allowsPictureInPicturePlayback = true
                playerController.delegate = self
                playerController.player?.play()
                self.present(playerController, animated: true, completion : nil)
    }
    
    @objc func didfinishPlaying(note : NSNotification)  {
        playerController.dismiss(animated: true, completion: nil)
        let alertView = UIAlertController(title: "Finished", message: "Video finished", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Okey", style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        let currentviewController = navigationController?.visibleViewController
        if currentviewController != playerViewController{
            currentviewController?.present(playerViewController, animated: true, completion: nil)
        }
    }
}

