//
//  WordDetailViewController.swift
//  vocabook
//
//  Created by Karl Lim on 1/29/23.
//

import AVFoundation
import UIKit

class WordDetailViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var wordNameLbl: UILabel!
    @IBOutlet weak var wordDescriptionLbl: UILabel!
    @IBOutlet weak var partOfSpeechLbl: UILabel!
    @IBOutlet weak var phoneticLbl: UILabel!
    @IBOutlet weak var playAudioBtn: UIButton!
    
    var wordbook: Wordbook?
    var myWord: Word?
    var sessionManager: AFHTTPSessionManager?
    var audioFileUrl: String = ""
    var player:AVPlayer?
    var playerItem:AVPlayerItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        RequestHelper.shared.getWordDetails(word: myWord!.name) { [self] wordbook,err  in
            print(#function)
            if wordbook.indices.contains(0) {
                self.wordbook = wordbook[0]
            
                DispatchQueue.main.async {
                    for phonetic in wordbook[0].phonetics {
                        print(phonetic.audio)
                        print(phonetic.audio != nil)
                        if (!(phonetic.audio?.isEmpty ?? true)) {
                            self.audioFileUrl = phonetic.audio!
                            break
                        }
                    }
                    self.wordNameLbl.text = self.wordbook?.word
                    self.wordDescriptionLbl.text = self.wordbook?.meanings[0].definitions[0].definition
                    self.phoneticLbl.text = self.wordbook?.phonetic
                    self.partOfSpeechLbl.text = self.wordbook?.meanings[0].partOfSpeech
                    
                    print(wordbook[0])
                    print(self.audioFileUrl)
                    initAudioPlayer(url: self.audioFileUrl)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
        
//        self.wordNameLbl.text = self.wordbook?.word
//        wordDescriptionLbl.text = self.wordbook?.meanings[0].definitions[0].definition
//        phoneticLbl.text = self.wordbook?.phonetic
//        partOfSpeechLbl.text = self.wordbook?.meanings[0].partOfSpeech
    }
    
    override func viewDidLayoutSubviews() {
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print(#function)
    }
    
    @IBAction func didTapPlayAudio(_ sender: Any) {
        if ((player) != nil)  {
            player!.seek(to: CMTime.zero)
            player!.play()
        } else {
            print("Player not initialized")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print(#function)
    }
    
    private func initAudioPlayer(url: String?) {
        // setup audio player
        if let audioUrl = URL(string: url!) {
            let playerItem:AVPlayerItem = AVPlayerItem(url: audioUrl)
            player = AVPlayer(playerItem: playerItem)
            let playerLayer=AVPlayerLayer(player: player!)
            playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
            self.view.layer.addSublayer(playerLayer)
        } else {
            print("audio url is empty ")
        }
    }

}
