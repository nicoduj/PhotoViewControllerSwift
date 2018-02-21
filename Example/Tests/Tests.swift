// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import PhotoViewControllerSwift

class PhotoViewControllerSwiftSpec: QuickSpec {
    
    override func spec() {
        
        var pvc : PhotoViewControllerSwift!
        
        beforeEach {

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // 2. Use the storyboard to instantiate the view controller.
            pvc = storyboard.instantiateViewController(
                    withIdentifier: "TestViewController") as! PhotoViewControllerSwift

            
        }
        
        describe("SampleView Test") {
            

            
            beforeEach {
                let _ = pvc.view
                /*
                pvc = UIStoryboard(name: "Main", bundle:
                    nil).instantiateViewController(withIdentifier:
                        "TestViewController") as! PhotoViewControllerSwift
                _ = pvc.view*/
                
            }
            
            
            
            context("when the view loaded") {
                it("Verifying the valid views") {
                    expect(pvc.myView) !== nil
                }
                
                it("Verifying that the image is set") {
                    expect(pvc.myImage) !== nil
                }
                
                it("Verifying that the image is set in the view") {
                    expect(pvc.myView.subviews.count ) > 0
                }
            }
            
            
        }
        
    }
}
