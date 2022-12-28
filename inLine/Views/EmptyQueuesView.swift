//
//  EmptyQueuesView.swift
//  inLine
//
//  Created by Marina De Pazzi on 28/12/22.
//

import SwiftUI
import SwiftyGif

struct EmptyQueuesView: View {
    var body: some View {
        VStack {
            Text("Things are looking **way** to peaceful")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .padding()
            
            Text("Be careful...")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .padding()
            
            ZStack {
                Color.white
                    .frame(width: 80, height: 5)
                    .padding(.leading)
                    .padding(.bottom, 36)
                
                SwiftyGif(name: "monkaHmm2.gif", loopCount: 100)
                    .frame(width: 100, height: 100)
            }
        }
    }
}

struct EmptyQueuesView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyQueuesView()
    }
}

class UIGIFImageView: UIView {
    private var image = UIImage()
    var imageView = UIImageView()
    private var data: Data?
    private var name: String?
    private var loopCount: Int?
    open var playGif: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(name: String, loopCount: Int, playGif: Bool) {
        self.init()
        self.name = name
        self.loopCount = loopCount
        self.playGif = playGif
        createGIF()
    }
    
    convenience init(data: Data, loopCount: Int, playGif: Bool) {
        self.init()
        self.data = data
        self.loopCount = loopCount
        self.playGif = playGif
        createGIF()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        self.addSubview(imageView)
    }
    
    func createGIF() {
        do {
            if let data = data {
                image = try UIImage(gifData: data)
            } else {
                image = try UIImage(gifName: self.name!)
            }
        } catch {
            print(error)
        }
        
        imageView = UIImageView(gifImage: image, loopCount: loopCount!)
        // .scaleAspectFit keeps the aspect ratio of the gif
        imageView.contentMode = .scaleAspectFit
    }
}

struct SwiftyGif: UIViewRepresentable {
    private let data: Data?
    private let name: String?
    private let loopCount: Int?
    @Binding var playGif: Bool
    
    init(data: Data, loopCount: Int = -1, playGif: Binding<Bool> = .constant(true)) {
        self.data = data
        self.name = nil
        self.loopCount = loopCount
        self._playGif = playGif
    }
    
    init(name: String, loopCount: Int = -1, playGif: Binding<Bool> = .constant(true)) {
        self.data = nil
        self.name = name
        self.loopCount = loopCount
        self._playGif = playGif
    }
    
    func makeUIView(context: Context) -> UIGIFImageView {
        var gifImageView: UIGIFImageView
        if let data = data {
            gifImageView = UIGIFImageView(data: data, loopCount: loopCount!, playGif: playGif)
        } else {
            gifImageView = UIGIFImageView(name: name!, loopCount: loopCount!, playGif: playGif)
        }
        return gifImageView
    }
    
    func updateUIView(_ gifImageView: UIGIFImageView, context: Context) {
        if playGif {
            gifImageView.imageView.startAnimatingGif()
        } else {
            gifImageView.imageView.stopAnimatingGif()
        }
    }
}
