//
//  ReservationViewController.swift
//  vocabook
//
//  Created by Karl Lim on 2/2/23.
//

import UIKit
import Kingfisher
import AVFoundation

class ReservationViewController: UIViewController {
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    
    @IBOutlet weak var sampleImageView: UIImageView!
    
    var sessionManager: AFHTTPSessionManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("REQUESTING SOMETHING")

        let url = URL(string: "https://nativecamp-public-web-production.s3-ap-northeast-1.amazonaws.com/2022_06_23_10280462b3c1a429965.jpg")
        sampleImageView.kf.setImage(with: url)

        sessionManager = CustomNetworkHelper.requestChatlogList {_,responseObject,error in
            if let response = responseObject as? NSDictionary {
//                if response["result"] == nil {
                    print(response)
//                }
            } else {
                print("ERROR: \(error?.localizedDescription)")
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.cancelRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // setup audio player
        let url = URL(string: "https://api.dictionaryapi.dev/media/pronunciations/en/pristine-1-us.mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        let playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
        self.view.layer.addSublayer(playerLayer)


        
        playButton = UIButton(type: UIButton.ButtonType.system) as UIButton
        let xPostion:CGFloat = 50
        let yPostion:CGFloat = 100
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        
        playButton!.frame = CGRect(x: xPostion, y: yPostion, width: buttonWidth, height: buttonHeight)
        playButton!.backgroundColor = UIColor.lightGray
        playButton!.setTitle("Play", for: UIControl.State.normal)
        playButton!.tintColor = UIColor.black
        playButton!.addTarget(self, action: #selector(self.playButtonTapped(_:)), for: .touchUpInside)
        
        self.view.addSubview(playButton!)
    }
    
    @objc func playButtonTapped(_ sender:UIButton){
        // Replay the current item
        player!.seek(to: CMTime.zero)
        player!.play()
    }
    
    func cancelRequest() {
        sessionManager?.invalidateSessionCancelingTasks(true, resetSession: true)
        print("CANCELLING REQUEST")
    }
    
    

}
