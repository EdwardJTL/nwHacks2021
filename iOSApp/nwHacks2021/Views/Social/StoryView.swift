//
//  StoryView.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-10.
//

import Combine
import Foundation
import SwiftUI

struct LoadingRectangle: View {
    var progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.3))
                    .cornerRadius(5)

                Rectangle()
                    .frame(width: geometry.size.width * progress, height: nil, alignment: .leading)
                    .foregroundColor(Color.white.opacity(0.9))
                    .cornerRadius(5)
            }
        }
    }
}

struct StoryView: View {
    @EnvironmentObject var storyTimer: StoryTimer
    @Binding var shown: Bool
    
    var images: [Image]
    
    let user: User
    let userIconSize: CGFloat = 20
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                images[Int(storyTimer.progress)]
                    .resizable()
                    .edgesIgnoringSafeArea([.horizontal, .bottom])
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    .animation(.none)
                VStack {
                    VStack {
                        HStack(alignment: .center, spacing: 4) {
                            ForEach(images.indices) { idx in
                                LoadingRectangle(progress: min(max((CGFloat(storyTimer.progress) - CGFloat(idx)), 0.0) , 1.0))
                                    .frame(width: nil, height: 2, alignment: .leading)
                                    .animation(.linear)
                            }
                        }
                        HStack {
                            Group {
                                if let safePfp = user.photo {
                                    safePfp
                                        .renderingMode(.original)
                                        .resizable()
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                }
                            }
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: userIconSize, height: userIconSize, alignment: .center)
                            .clipShape(Circle())
                            
                            Text(user.userName)
                                .foregroundColor(.white)
                                .font(.caption)
                            
                            Spacer()
                            
                            Button(action: {
                                $shown.wrappedValue.toggle()
                            }, label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .aspectRatio(1, contentMode: .fill)
                                    .frame(width: userIconSize, height: userIconSize, alignment: .center)
                            })
                        }
                    }
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .bottom, endPoint: .top)
                    )
                    
                    // Invisible Controls
                    HStack(alignment: .center, spacing: 0) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.storyTimer.advance(by: -1)
                        }
                        Rectangle()
                            .foregroundColor(.clear)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.storyTimer.advance(by: 1)
                        }
                    }
                }
                
            }
            .onAppear { self.storyTimer.start() }
            .onDisappear {self.storyTimer.cancel() }
        }
    }
}

class StoryTimer: ObservableObject {
    @Published var progress: Double
    var interval: TimeInterval
    var max: Int
    private let publisher: Timer.TimerPublisher
    private var cancellable: Cancellable?
    
    var completionHandler: () -> Void
    
    init(items: Int, interval: TimeInterval, completionHandler: @escaping () -> Void) {
        self.max = items
        self.progress = 0
        self.interval = interval
        self.publisher = Timer.publish(every: 0.1, on: .main, in: .default)
        self.completionHandler = completionHandler
    }
    
    func start(max: Int? = nil, interval: TimeInterval? = nil) {
        if let max = max {
            self.max = max
        }
        if let interval = interval {
            self.interval = interval
        }
        self.cancellable = self.publisher.autoconnect()
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                var newProgress = self.progress + (0.1 / self.interval)
                if Int(newProgress) >= self.max {
                    newProgress = 0
                    self.completionHandler()
                }
                self.progress = newProgress
            })
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    func advance(by number: Int) {
        let newProgress = Swift.max((Int(self.progress) + number) % self.max , 0)
        self.progress = Double(newProgress)
    }
}

struct StoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        StoryView(shown: .constant(true), images: [Image("knitting"), Image("backflip")], user: User.defaultUser())
            .environmentObject(StoryTimer(items: 2, interval: 3.0, completionHandler: {}))
    }
}
