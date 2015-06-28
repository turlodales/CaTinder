import UIKit

class GGDraggableView: UIView {

    var panGestureRecognizer : UIPanGestureRecognizer!
    var originalPoint:CGPoint!
    
   
    
    override init(frame: CGRect){
        super.init(frame : frame)
        self.backgroundColor = UIColor.greenColor()
        
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("dragged:"))
        self.addGestureRecognizer(panGestureRecognizer)
        
        self.loadImageAndStyle()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func loadImageAndStyle(){
        let url = NSURL(string: "IMAGES/catinder/test/image.jpg")
        let data = NSData(contentsOfURL: url!)
        let image = UIImage(data: data!)
        let imageView = UIImageView(image: image!)
        self.addSubview(imageView)
        self.layer.cornerRadius = 0
        self.layer.shadowOffset = CGSizeMake(0, 0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
    }
    
    func dragged(gestureRecognizer: UIPanGestureRecognizer) {
  
        let xDistance:CGFloat = gestureRecognizer.translationInView(self).x
        let yDistance:CGFloat = gestureRecognizer.translationInView(self).y
        
        switch(gestureRecognizer.state){
        case UIGestureRecognizerState.Began:
            self.originalPoint = self.center
            
        case UIGestureRecognizerState.Changed:
            let rotationStrength:CGFloat = min((xDistance/320),1)
            let rotationAngel:CGFloat = (2.00*CGFloat(M_PI)*CGFloat(rotationStrength) / 16.00)
            let scaleStrength:CGFloat = 1.00 - CGFloat(fabsf(Float(rotationStrength))) / 4.00
            let scale:CGFloat = max(scaleStrength, 0.93);
            
            self.center = CGPointMake(self.originalPoint.x + xDistance, self.originalPoint.y + yDistance)
            let transform:CGAffineTransform = CGAffineTransformMakeRotation(rotationAngel)
            let scaleTransform:CGAffineTransform = CGAffineTransformScale(transform, scale, scale)
            self.transform = scaleTransform
            
        case UIGestureRecognizerState.Ended:
            self.resetViewPositionAndTransformations()
            
        default:
            println("error default statement")
            
        }
    }
    
    func resetViewPositionAndTransformations(){
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.center = self.originalPoint
            self.transform = CGAffineTransformMakeRotation(0)
        })
    }

}
