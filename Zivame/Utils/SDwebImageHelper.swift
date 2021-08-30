//
//  SDwebImageHelper.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 14/08/21.
//

import Foundation
import SDWebImage

import Foundation

public enum PageViewType : String{
    case Listing
    case PDP
    case HorizonalScroller
}

class ImageSelectionHelper {
    
    static let sharedInstance = ImageSelectionHelper()
    //Using a concurrent queue means that multiple reads from multiple threads aren't blocking each other. Since there is no mutation on getting, the value can be read concurrently, because...
    private let dispatchQueue = DispatchQueue(label: "ImageSelectionHelper",attributes : .concurrent)
    private var _availableImageQualities : [String : Int] = ["thumbnail": 94,     "medium": 309,     "large": 568,     "preview": 1094 ]
    var availableImageQualities : [String : Int]{
        get{
            var returnDict = [String : Int]()
            dispatchQueue.sync{
                returnDict = _availableImageQualities
            }
            return returnDict
        }
        set{
            // We are setting the new values using a .barrier async dispatch. The block can be performed asynchronously because there is no need for the caller to wait for the value to be set. The block will not be run until all the other blocks in the concurrent queue ahead of it have completed.
            dispatchQueue.async(flags: .barrier) {
                self._availableImageQualities = newValue
            }
        }
    }
    
    var _SCALE_FACTOR : Float = 1.294
    private var SCALE_FACTOR: Float{
        get{
            var scaleFactor : Float = 1.294
            dispatchQueue.sync{
                scaleFactor = self._SCALE_FACTOR
            }
            return scaleFactor
        }
        set{
            // We are setting the new values using a .barrier async dispatch. The block can be performed asynchronously because there is no need for the caller to wait for the value to be set. The block will not be run until all the other blocks in the concurrent queue ahead of it have completed.
            dispatchQueue.async(flags: .barrier) {
                self._SCALE_FACTOR = newValue
            }
        }
    }
    
    var _MAXDOWNGRADE_LIMIT = -50
    private var MAXDOWNGRADE_LIMIT: Int{
        get{
            var maxLimit : Int = -50
            dispatchQueue.sync{
                maxLimit = self._MAXDOWNGRADE_LIMIT
            }
            return maxLimit
        }
        set{
            // We are setting the new values using a .barrier async dispatch. The block can be performed asynchronously because there is no need for the caller to wait for the value to be set. The block will not be run until all the other blocks in the concurrent queue ahead of it have completed.
            dispatchQueue.async(flags: .barrier) {
                self._MAXDOWNGRADE_LIMIT = newValue
            }
        }
    }
    var _optimizedImageKeysDictionary = [String : String]()
    private var optimizedImageKeysDictionary : [String : String] {
        get{
            var returnDict = [String : String]()
            dispatchQueue.async(flags: .barrier) {
                returnDict = self._optimizedImageKeysDictionary
            }
            return returnDict
        }
        set{
            // We are setting the new values using a .barrier async dispatch. The block can be performed asynchronously because there is no need for the caller to wait for the value to be set. The block will not be run until all the other blocks in the concurrent queue ahead of it have completed.
            dispatchQueue.sync{
                self._optimizedImageKeysDictionary = newValue
            }
        }
    }
    
    func load(){
    }
    
    private func setOptimizedImageKey(type : PageViewType?, imageKey : String){
        if let type = type{
            optimizedImageKeysDictionary[type.rawValue] = imageKey
        }
    }
    
    private func getOptimizedImageKey(type : PageViewType?) -> String?{
        if let type = type{
            return optimizedImageKeysDictionary[type.rawValue] ?? nil
        }
        return nil
    }
    
    
    
    /**
     Method to get best available image for current imageview resolution
     @param Image url of thumnail size
     @param Image view width in pixel
     @return Image url of optimum size
     */
    public func getOptimumImageURL(_ anyImageURL: URL,imageViewWidth : Int,pageViewType : PageViewType? = nil) ->URL?{
        var imageQulityKey : String? = nil
        var toBeReplacedString : String? = nil
        //Step 0 if already calculated in session
        if let imageKey = getOptimizedImageKey(type: pageViewType){
            imageQulityKey = imageKey
        }else{
            let MAXOFFSET = 10000
            //Step 1 update config image qualities
            //Step 2 find most nearer image
            var nearestImageWidthOffset = -1
            let imageKeys = Array(ImageSelectionHelper.sharedInstance.availableImageQualities.keys)
            for imageKey in imageKeys{
                if let imagewidth = ImageSelectionHelper.sharedInstance.availableImageQualities[imageKey]{
                    var offset = imagewidth - imageViewWidth
                    offset = abs(offset)
                    if offset < MAXDOWNGRADE_LIMIT{
                        offset = MAXOFFSET
                    }
                    if nearestImageWidthOffset == -1 || offset < nearestImageWidthOffset {
                        nearestImageWidthOffset = offset
                        imageQulityKey = imageKey
                    }
                }
            }
        }
        //Step 3
        //find current key sent from server
        let imageKeys = Array(ImageSelectionHelper.sharedInstance.availableImageQualities.keys)
        toBeReplacedString =  imageKeys.filter({anyImageURL.absoluteString.contains("/\($0)/")}).first
        //Step 4
        //return the optimal image url
        if let imageQulityKey = imageQulityKey,
            let toBeReplacedString = toBeReplacedString{
            let optimizedURL = anyImageURL.absoluteString.replacingOccurrences(of: "/\(toBeReplacedString)/", with: "/\(imageQulityKey)/")
            return URL(string: optimizedURL)
        }else{
            return anyImageURL
        }
    }
}
