//
//  SkillDetailView.swift
//  nwHacks2021
//
//  Created by Martin Yushko on 2021-01-09.
//

import SwiftUI

struct SkillDetailView: View {
    let skill: Skill
    @State var inProgressSkill: InProgressSkill? // There is a better way to implement this for sure lol
    
    let posterName: String //TODO replace with user
    @State var learning: Bool
    
    @State var presentingModalView: Bool = false
    @State var progressValue: Float = 0.0
    @State var description: String = ""
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    
    var body: some View {
        ZStack {
            Color.blue
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Group {
                        if let safeImage = skill.image {
                            // TODO change to poster user image
                            safeImage
                                .resizable()
                        } else {
                            Image("backflip")
                                .resizable()
                        }
                    }
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 60, height: 60, alignment: .leading)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(skill.title)
                            .font(.title)
                            .fontWeight(.medium)
                        Text("by \(posterName)")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    VStack {
                        Text(skill.description)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .truncationMode(.tail)
                            .frame(width: 300)
                    
                        //TODO right now this is a static picture but it should be playable media such as a video
                        Group {
                            if let safeImage = skill.image {
                                safeImage
                                    .resizable()
                            } else {
                                Image("backflip")
                                    .resizable()
                            }
                        }
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 300, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        
                    }
                    .foregroundColor(.white)
                }
                HStack{
                    Spacer()
                    VStack {
                        if (!learning) {
                            Button("Learn", action: {
                                //TODO update backend to indicate user has new in progress skill
                                self.inProgressSkill = InProgressSkill(skill: self.skill, startedAt: Date(), completed: false)
                                self.learning.toggle()
                            })
                            .buttonStyle(GradientBackgroundStyle(startColor: Color.orange, endColor: Color.pink))
                            .frame(height: 60)
                            .padding()
                        } else if let safeSkill = inProgressSkill {
                            
                            if (!safeSkill.completed) {  // currently in progress
                            Button("I'm Done!", action: {
                                //TODO update backend to indicate user has completed this skill
                                
                                self.inProgressSkill!.completed = true
                                presentingModalView = true

                            })
                            .buttonStyle(GradientBackgroundStyle(startColor: Color.yellow, endColor: Color.green))
                            .frame(height: 60)
                            .offset(y: 10)
                            
                                Text("Started on " + toDateString(from: safeSkill.startedAt, format: "MMM d HH:mm a"))
                                    .foregroundColor(.white)
                                    .offset(y:10)
                                
                            } else {  // this is one of the user's learned skills.
                            }
                           
                        }
                    }
                }
            }
        }.sheet(isPresented: $presentingModalView, content: {
            
            VStack {
                Text("CONGRATULATIONS!")
                    .foregroundColor(.pink)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                ProgressBar(value: $progressValue).frame(height: 20)
                
                TextField("Share your experience...", text: $description, onCommit: {
                    progressValue += 0.50 //WARNING
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 100)
                
                Button(action: {
                    progressValue += 0.50 //WARNING - delay somehow?
                    self.showCaptureImageView.toggle()
                                }) {
                                    Text("Choose photo/video")
                                }
                                image?.resizable()
                                  .frame(height: 250)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                 // .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                 // .shadow(radius: 10)
                                    .padding()
                
                if (showCaptureImageView) {
                        CaptureImageView(isShown: $showCaptureImageView, image: $image)
                    }
                
                Spacer()
                
                Button("Share With Friends", action: {
                    presentingModalView = false
                    //TODO set to public
                })
                .buttonStyle(GradientBackgroundStyle(startColor: Color.orange, endColor: Color.purple))
                .frame(height: 60)
                .disabled(progressValue < 1)
               // .offset(y: 10)
                
                Button("Keep Private", action: {
                    presentingModalView = false
                    //TODO set to private

                })
                .offset(y: 20)
                .buttonStyle(GradientBackgroundStyle(startColor: Color.gray, endColor: Color.blue))
                .frame(height: 60)
                .disabled(progressValue < 1)
               // .offset(y: 10)
                
                Spacer()
            }
            .padding()
            //.background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.yellow]), startPoint: .bottom, endPoint: .top).opacity(0.5))
        })
        
    }
    
}

struct CaptureImageView {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    
    func makeCoordinator() -> Coordinator {
      return Coordinator(isShown: $isShown, image: $image)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @Binding var isCoordinatorShown: Bool
  @Binding var imageInCoordinator: Image?
  init(isShown: Binding<Bool>, image: Binding<Image?>) {
    _isCoordinatorShown = isShown
    _imageInCoordinator = image
  }
  func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
     imageInCoordinator = Image(uiImage: unwrapImage)
     isCoordinatorShown = false
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     isCoordinatorShown = false
  }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}

struct GradientBackgroundStyle: ButtonStyle {
 
    var startColor: Color
    var endColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .leading, endPoint: .trailing).opacity(configuration.isPressed ? 0.5 : 1))
            .cornerRadius(25)
            .shadow(radius: 10)
            .font(.title)
    }
}

struct ProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}

struct SkillDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SkillDetailView(skill: Skill(title: "Test Skill", categories: ["Test"], completedCount: 10, estimatedTime: TimeInterval(180), description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse eu arcu nec mi posuere rutrum quis nec elit. Phasellus blandit viverra molestie. Nam erat metus, fermentum tincidunt fringilla et, gravida id erat. Donec euismod magna lectus, et faucibus augue accumsan sed. Aenean accumsan tincidunt vestibulum. Vivamus sit amet quam eget eros congue scelerisque non ac mauris. Nulla fringilla, justo nec sagittis scelerisque, neque justo tempus tellus, vel suscipit mauris metus vulputate turpis. In vitae neque erat. Sed aliquet rutrum leo, nec blandit enim malesuada quis. Sed suscipit eget felis ac egestas. Integer iaculis nisl rutrum, semper elit eget, volutpat lacus. Ut ut massa mi. Donec efficitur varius convallis. Suspendisse ac tincidunt libero.", image: Image("knitting"), videoURL: nil), posterName: "Test Name", learning: false)
    }
}
