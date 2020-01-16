//
//  Indicator.swift
//
//


import UIKit
import NVActivityIndicatorView
import NotificationBannerSwift


class Indicator: NSObject , NVActivityIndicatorViewable {
    var activityData = ActivityData()
    static let shared = Indicator()
    
    func startAnimating(withMessage : String) {
        activityData = ActivityData(size: CGSize(width: 80, height: 80),
                                    message: withMessage,
                                    messageFont: UIFont(name: "Avenir-Roman", size: 14),
                                    type: NVActivityIndicatorType.ballScaleMultiple,
                                    color: UIColor.white,
                                    padding: 0,
                                    displayTimeThreshold: NVActivityIndicatorView.DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD,
                                    minimumDisplayTime: NVActivityIndicatorView.DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME,
                                    backgroundColor: NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR,
                                    textColor: NVActivityIndicatorView.DEFAULT_TEXT_COLOR)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData, nil)
    }
    func stopAnimating(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}


//class StatusBanner: NSObject , BaseNotificationBanner{
//    static let shared = StatusBanner()
//    var banner : StatusBarNotificationBanner()
//    func startAnimating(withMessage : String) {
//        let banner = StatusBarNotificationBanner(title: "Internet not available", style: .danger)
//        banner.dismissDuration = 1.2
//        banner.show(queuePosition: .front, bannerPosition: .top)
//    }
//    func stopAnimating(){
//        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
//    }
//}


class InternetBanner{
    
    static let shared = InternetBanner()
    
    var banner : StatusBarNotificationBanner?
    
    //Initializer access level change now
    private init(){}
    
    func show(withMessage : String){
        banner = StatusBarNotificationBanner(title: withMessage, style: .danger)
        banner?.autoDismiss = true
        banner?.duration = 1.2
        banner?.bannerHeight = 120
        banner?.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 15)
        banner?.show(queuePosition: .front, bannerPosition: .top)
    }
    
    func hide(){
        banner?.dismiss()
    }
}


class ERRORBanner{
    
    static let shared = ERRORBanner()
    
    var banner : GrowingNotificationBanner?
    
    //Initializer access level change now
    private init(){}
    
    func show(message : String,title : String){
        banner = GrowingNotificationBanner(
                        title: title,
                        subtitle: """
                            \(message)
                            """,
                      style: .success)
        banner?.autoDismiss = true
        banner?.duration = 1.2
        banner?.backgroundColor = UIColor(red: 0/255.0, green: 127/255.0, blue: 243/255.0, alpha: 1.0)
        banner?.subtitleLabel?.font = UIFont(name: "Avenir-Medium", size: 15)
        banner?.titleLabel?.font = UIFont(name: "Avenir-Black", size: 17)
        banner?.show(queuePosition: .front, bannerPosition: .top)
    }
    
    func hide(){
        banner?.dismiss()
    }
}
