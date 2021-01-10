//
//  SocialView.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-10.
//

import Combine
import Foundation
import SwiftUI

struct SocialView: View {
    @EnvironmentObject var storiesHolder: Stories
    @EnvironmentObject var currentUser: UserData
    @EnvironmentObject var posts: PostData
    @State var showingStory = false
    @State var currentStory: Story!
    
    let storySpacing: CGFloat = 20
    let storyTextSpacing: CGFloat = 8
    let storyIconSize: CGFloat = 65
    let storyPlusIconSize: CGFloat = 25
    let storyHaloSize: CGFloat = 70
    let storyRowHeight: CGFloat = 120
    
    let storyTimerDuration = 2.0
    
    var body: some View {
        ZStack {
            // Main interface
            VStack {
                // Stories
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: storySpacing) {
                        Button(action: {
                            // function to create new story
                        }) {
                            VStack(spacing: storyTextSpacing) {
                                ZStack(alignment: .topTrailing) {
                                    Group {
                                        if let safePfp = currentUser.user.photo {
                                            safePfp
                                                .renderingMode(.original)
                                                .resizable()
                                        } else {
                                            Image(systemName: "person.crop.circle.fill")
                                                .resizable()
                                        }
                                    }
                                    .aspectRatio(1, contentMode: .fill)
                                    .frame(width: storyIconSize, height: storyIconSize, alignment: .center)
                                    .clipShape(Circle())
                                    
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .foregroundColor(.blue)
                                        .padding(2)
                                        .background(Color.white)
                                        .aspectRatio(1, contentMode: .fill)
                                        .frame(width: storyPlusIconSize, height: storyPlusIconSize)
                                        .clipShape(Circle())
                                        .offset(x: 5, y: -5)
                                }
                                
                                Text("Your Story")
                                    .font(.caption)
                                    .foregroundColor(.secondaryLabel)
                            }
                        }
                        
                        ForEach(storiesHolder.data.indices) { idx in
                            StoryIconView(storyTextSpacing: storyTextSpacing - 1,
                                          storyIconSize: storyIconSize,
                                          haloSize: storyHaloSize,
                                          story: storiesHolder.data[idx])
                                .onTapGesture {
                                    withAnimation(Animation.default.speed(0.35).repeatForever(autoreverses: false)) {
                                        self.storiesHolder.data[idx].rotating.toggle()
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + (storiesHolder.data[idx].seenAll ? 0 : 1.2)) {
                                            self.currentStory = self.storiesHolder.data[idx]
                                            
                                            withAnimation(.default) {
                                                self.showingStory.toggle()
                                            }
                                            
                                            self.storiesHolder.data[idx].rotating = false
                                            self.storiesHolder.data[idx].seenAll = true
                                        }
                                    }
                                }
                                .fullScreenCover(isPresented: $showingStory, content: {
                                    StoryView(shown: $showingStory, images: currentStory.images, user: currentStory.user)
                                        .environmentObject(StoryTimer(items: currentStory.images.count,
                                                                      interval: storyTimerDuration,
                                                                      completionHandler: {
                                                                        self.showingStory.toggle()
                                                                      }))
                                })
                        }
                    }
                    .padding([.horizontal, .top])
                }
                .frame(height: storyRowHeight)
                
                Divider()
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        ForEach(posts.data.indices) { idx in
                            PostCardView(clapped: $posts.claps[idx],
                                         comment: $posts.comments[idx],
                                         post: posts.data[idx])
                                .padding()
                        }
                    }
                }
            }
        }
    }
}

struct StoryIconView: View {
    let storyTextSpacing: CGFloat
    let storyIconSize: CGFloat
    let haloSize: CGFloat
    
    let story: Story
    
    var body: some View {
        VStack(spacing: storyTextSpacing) {
            ZStack {
                Group {
                    if let safePfp = story.user.photo {
                        safePfp
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                    }
                }
                .aspectRatio(1, contentMode: .fill)
                .frame(width: storyIconSize, height: storyIconSize, alignment: .center)
                .clipShape(Circle())
                
                if !story.seenAll {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(AngularGradient(gradient: .init(colors: [.red, .orange, .red]),
                                                center: .center),
                                style: StrokeStyle(lineWidth: 4, dash: [story.rotating ? 7 : 0]))
                        .frame(width: haloSize, height: haloSize, alignment: .center)
                        .rotationEffect(.init(degrees: story.rotating ? 360 : 0))
                }
            }
            
            Text(story.user.userName)
                .font(.caption)
                .foregroundColor(.blue)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(width: storyIconSize)
        }
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SocialView()
                .navigationTitle("")
                .navigationBarHidden(true)
        }
            .environmentObject(UserData(user: PreviewUser().data))
            .environmentObject(Stories(stories: PreviewStories().data))
            .environmentObject(PostData(posts: PreviewPosts().data))
    }
}
