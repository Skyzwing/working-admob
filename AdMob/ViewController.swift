//
//  ViewController.swift
//  AdMob
//
//  Created by Surachat Yaitammasan on 18/3/2563 BE.
//  Copyright © 2563 Surachat Yaitammasan. All rights reserved.
//
// App ID: ca-app-pub-8053187318902731~6266260684
// Banner ID: ca-app-pub-8053187318902731/1943872294
// Reward ID: ca-app-pub-8053187318902731/2171937153

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    
    
    @IBOutlet weak var rewardCount: UILabel!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var rewardAds: GADRewardedAd?
    var count = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rewardAds = createAndLoadRewardedAd()
        
        initBase()
    }
    
    func initBase() {
        initBannerAds()
        createAndLoadRewardedAd()
    }
    
    func initBannerAds() {
        bannerView.adUnitID = "ca-app-pub-8053187318902731/1943872294"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    func createAndLoadRewardedAd() -> GADRewardedAd {
      rewardAds = GADRewardedAd(adUnitID: "ca-app-pub-8053187318902731/2171937153")
      rewardAds?.load(GADRequest()) { error in
        if let error = error {
          print("Loading failed: \(error)")
        } else {
          print("Loading Succeeded")
        }
      }
        return rewardAds!
    }

    @IBAction func rewardButton(_ sender: Any) {
        if rewardAds?.isReady == true {
            rewardAds?.present(fromRootViewController: self, delegate: self)
        }
    }
}

extension ViewController: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Ada recieve")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(error)
    }
}

extension ViewController: GADRewardedAdDelegate {
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        count += 10
        rewardCount.text = String(count)
    }
    
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        print("Reward ads is present")
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        rewardAds = createAndLoadRewardedAd()
        print("Reward ads is dismiss")
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        print("reward ads error: \(error)")
    }
}
