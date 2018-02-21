//
//  PhotoViewControllerSwift.h
//
//  Created by Nicolas Dujardin
//  Copyright (c) 2018 Nicolas Dujardin. All rights reserved.
//

import UIKit

/**
 Instances of `PhotoViewController` create a viewController that supports UIScrollViewDelegate
 
 In order to use this, you need to :
 - inherit form this interface like this : @interface MyViewController : PhotoViewController
 - In your viewDidLoad event :
 - Set the UIScrollView : self.myView = self.mainView; (assuming you have an IBOutlet to your UIScrollView named "mainView" on your storyboard)
 - Set the image self.myImage = [UIImage imageNamed:@"toto.jpg"]; (you can do it later, bnut in this case you will need to call showImage().
 
 */
open class PhotoViewControllerSwift : UIViewController
{
    
    var myViewValue: UIScrollView!
    
    /**
     Specifies the scrollView that will be used
     */
    public var myView : UIScrollView!  {
        get{
            return myViewValue
        }
        set{
            myViewValue = newValue
            myViewValue.delegate = self
            let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.scrollViewDoubleTapped(_:)))
            doubleTapRecognizer.numberOfTapsRequired = 2
            doubleTapRecognizer.numberOfTouchesRequired = 1
            self.myView.addGestureRecognizer(doubleTapRecognizer)
            
            let twoFingerTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.scrollViewTwoFingerTapped(_:)))
            twoFingerTapRecognizer.numberOfTapsRequired = 1
            twoFingerTapRecognizer.numberOfTouchesRequired = 2
            myViewValue.addGestureRecognizer(twoFingerTapRecognizer)
            
            
        }
    }
    /**
     Specifies the image that will be displayed
     */
    public var myImage : UIImage!
    
    public var imageView : UIImageView!
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        menuButton.setImage(UIImage(named: "Backspace.png"), for: .normal)
        menuButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        let menuItem = UIBarButtonItem(customView: menuButton)
        self.navigationItem.leftBarButtonItem = menuItem
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override open func viewDidAppear(_ animated : Bool)
    {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if (self.myImage != nil)
        {
            self.perform(#selector(showImage), with: nil, afterDelay: 0.2)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientationChanged),
            name: Notification.Name("UIDeviceOrientationDidChangeNotification"),
            object: nil)
        
    }
    
    
    override open func viewDidDisappear(_ animated : Bool)
    {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("UIDeviceOrientationDidChangeNotification"), object: nil)
    }
    
    
    @objc private func orientationChanged()
    {
        if (self.imageView != nil)
        {
            self.centerScrollViewContents()
        }
    }
    
    /**
     Allows you to force image refresh in case you changed it.
     */
    @objc open func showImage()
    {
        
        for  view in self.myView.subviews
        {
            view.removeFromSuperview()
        }
        
        
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.myImage.size.width, height: self.myImage.size.height))
        self.imageView.image = self.myImage
        self.myView.addSubview(self.imageView)
        self.myView.contentSize = self.myImage.size
        
        let scrollViewFrame = self.myView.frame
        let scaleWidth = scrollViewFrame.size.width / self.myView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / self.myView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        self.myView.minimumZoomScale = minScale
        self.myView.maximumZoomScale = 1
        self.myView.zoomScale = minScale
        self.centerScrollViewContents()
        
    }
    
    
    
    public func centerScrollViewContents() {
        
        let boundsSize = self.myView.bounds.size;
        var contentsFrame = self.imageView.frame;
        
        if (contentsFrame.size.width < boundsSize.width) {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2;
        } else {
            contentsFrame.origin.x = 0;
        }
        
        if (contentsFrame.size.height < boundsSize.height) {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2;
        } else {
            contentsFrame.origin.y = 0;
        }
        
        self.imageView.frame = contentsFrame;
        
    }
    
    
    @objc private func scrollViewDoubleTapped(_ recognizer : UITapGestureRecognizer) {
        
        // Get the location within the image view where we tapped
        let  pointInView = recognizer.location(in: self.imageView)
        
        // Get a zoom scale that's zoomed in slightly, capped at the maximum zoom scale specified by the scroll view
        var newZoomScale = self.myView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, self.myView.maximumZoomScale)
        
        // Figure out the rect we want to zoom to, then zoom to it
        let scrollViewSize = self.myView.bounds.size
        
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2)
        let y = pointInView.y - (h / 2)
        
        let rectToZoomTo = CGRect(x: x, y: y, width: w, height: h)
        
        self.myView.zoom(to: rectToZoomTo, animated: true)
        
        
    }
    
    @objc private func scrollViewTwoFingerTapped(_ recognizer : UITapGestureRecognizer) {
        
        // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
        var newZoomScale = self.myView.zoomScale / 1.5
        newZoomScale = max(newZoomScale, self.myView.minimumZoomScale)
        self.myView.setZoomScale(newZoomScale, animated: true)
    }
    
    
    
    @objc private func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension PhotoViewControllerSwift : UIScrollViewDelegate
{
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        // Return the view that we want to zoom
        return self.imageView;
    }
    
    public func scrollViewDidZoom(_ scrollView : UIScrollView ) {
        // The scroll view has zoomed, so we need to re-center the contents
        self.centerScrollViewContents()
    }
}
