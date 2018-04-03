//
//  main.swift
//  Threads
//
//  Created by Kanwar Zorawar Singh Rana on 12/23/17.
//  Copyright © 2017 Kanwar Zorawar Singh Rana. All rights reserved.
//

import Foundation

class MyThread:NSObject{
    
    var thread : Thread?
    var task: URLSessionDownloadTask!
    
    func initiate(){
        //startThread()
        downloadImage()
        //stopThread()
        perform(#selector(stopThread), with: nil, afterDelay: 5)
    }
    
    
    func startThread() {
        print("thread started")
        thread = Thread.init(target:self , selector: #selector(downloadImage), object: nil)
        thread?.start()
        perform(#selector(stopThread), with: nil, afterDelay: 3)
        
    }
    
    @objc func stopThread() {
        print("thread cancel")
        //thread?.cancel()
        task.cancel()
    }
    
    @objc func downloadImage() {
        let urlString = "https://fpdl.vimeocdn.com/vimeo-prod-archive-std-us/videos/896164697?token=1514258532-0xc39cb1915114c86aafa00ee0a7650d8ac5d374f8&download=1&filename=Lights+-+13441.mp4"
        
        print("is main thread: \(Thread.isMainThread)")
        
        let url = URL.init(string: urlString)
        let session = URLSession.shared
        let startData = Date()
//        let task = session.dataTask(with: url!) { (data, response, error) in
//            print(data?.description ?? "no")
//            print("Got data")
//            let endDate = Date()
//            print("Time Takem: \(endDate.timeIntervalSince(startData))")
//        }
        print("Download in process")
        task = session.downloadTask(with: url!) { (url, response, error) in
            
            print("Got data")
            let endDate = Date()
            print("Time Takem: \(endDate.timeIntervalSince(startData))")
        }
        task.resume()
    }
    
    @objc func threadProcess() {
        
        while true {
            print(thread?.isMainThread)
            //RunLoop.current.run()
            print("is running\(Date())")
        }
        
    }
}

let obj = MyThread()

obj.initiate()
//obj.startThread()
//obj.stopThread()
//obj.perform(#selector(MyThread.stopThread), on: Thread.main, with: nil, waitUntilDone: false)

while true {
    sleep(1)
    //print("value:: \(obj.thread?.isExecuting)")
}



