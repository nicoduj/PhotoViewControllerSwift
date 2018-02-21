//
//  ViewController.swift
//  PhotoViewControllerSwift
//
//  Created by nicoduj on 02/20/2018.
//  Copyright (c) 2018 nicoduj. All rights reserved.
//

import UIKit
import PhotoViewControllerSwift


class SampleView: PhotoViewControllerSwift
{
    
    @IBOutlet var scview: UIScrollView!

    override open func viewDidLoad()
    {
        super.viewDidLoad()
        self.myView = self.scview
        self.myImage = UIImage(named: "40110298232_4e9c412936_o.jpg")
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
}

