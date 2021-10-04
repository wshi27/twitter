//
//  TweetViewController.swift
//  Twitter
//
//  Created by Weiwei Shi on 9/28/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var charCountLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(tweetTextView)
        tweetTextView.becomeFirstResponder()
        let borderGray = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.tweetTextView.layer.borderColor = borderGray.cgColor
        self.tweetTextView.layer.borderWidth = 0.5
        self.tweetTextView.layer.cornerRadius = 5
        
        tweetTextView.delegate = self
        
        

        // Do any additional setup after loading the view.
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: {
                (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 280
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        let charLeft = String(characterLimit - newText.count)
        charCountLabel.text = charLeft
        return newText.count < characterLimit
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
