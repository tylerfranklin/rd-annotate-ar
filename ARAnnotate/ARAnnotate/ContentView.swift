//
//  ContentView.swift
//  ARAnnotate
//
//  Created by Tyler Franklin on 9/25/20.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif


//import SwiftUI
//
//// --------------------------------------------------------------------------------
//// UINavigationController
//// --------------------------------------------------------------------------------
//NavigationView {
//    Spacer()    // TODO: replace with the actual content
//}
//
//// --------------------------------------------------------------------------------
//// LoginViewController
//// --------------------------------------------------------------------------------
//struct LoginView: View {
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .topLeading) {
//                Image(systemName: "")
//
//                Text("Annotate AR")
//                    .font(.system(size: 85))
//                    .offset(x: 0, y: 693)
//                    .frame(width: 414, height: 102)
//            }
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
//        }
//    }
//}
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
//
//// --------------------------------------------------------------------------------
//// UIViewController
//// --------------------------------------------------------------------------------
//struct UIView: View {
//    var body: some View {
//        // TODO: Unsupported element class: ARSKView
//    }
//}
//
//struct UIView_Previews: PreviewProvider {
//    static var previews: some View {
//        UIView()
//    }
//}
//
//// --------------------------------------------------------------------------------
//// AnnotationListViewController
//// --------------------------------------------------------------------------------
//struct AnnotationListView: View {
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .topLeading) {
//                List {
//                    Spacer()    // TODO: replace with the actual content
//                }
//
//                Button(action: {}) {
//                    Text("Create")
//                        .frame(width: 414, height: 81, alignment: .center)
//                }
//                .aspectRatio(contentMode: .fill)
//                .font(.system(size: 48))
//                .offset(x: 0, y: 779)
//            }
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
//        }
//    }
//}
//
//struct AnnotationListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnnotationListView()
//    }
//}
//
//// --------------------------------------------------------------------------------
//// AnnotationDetailViewController
//// --------------------------------------------------------------------------------
//struct AnnotationDetailView: View {
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .topLeading) {
//                List {
//                    Spacer()    // TODO: replace with the actual content
//                }
//
//                struct ContentView: View {
//                    var body: some View {
//                        GeometryReader { geometry in
//                            ZStack(alignment: .topLeading) {
//                                Text("Collect Annotation")
//                                    .font(.custom("Thonburi", size: 20))
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(Color(red: 0.9948267, green: 1.0, blue: 0.9978077))
//                                    .frame(width: 414, height: 54)
//
//                                // TODO: Unsupported element class: UIActivityindicatorView
//                            }
//                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
//                        }
//                    }
//                }
//
//                struct ContentView_Previews: PreviewProvider {
//                    static var previews: some View {
//                        ContentView()
//                    }
//                }
//
//                Text("Collectors")
//                    .font(.custom("Thonburi", size: 17))
//                    .offset(x: 30, y: 325)
//                    .frame(width: 82, height: 23)
//
//                Text("Author Label")
//                    .font(.system(size: 17))
//                    .offset(x: 25, y: 88)
//                    .frame(width: 98, height: 21)
//
//                Text("Book Label")
//                    .font(.system(size: 17))
//                    .offset(x: 25, y: 117)
//                    .frame(width: 85, height: 21)
//
//                Text("Date Label")
//                    .font(.system(size: 17))
//                    .multilineTextAlignment(.trailing)
//                    .offset(x: 312, y: 88)
//                    .frame(width: 82, height: 21)
//
//                Text("Page Label")
//                    .font(.system(size: 17))
//                    .multilineTextAlignment(.trailing)
//                    .offset(x: 309, y: 117)
//                    .frame(width: 85, height: 21)
//
//                // TODO: Unsupported element class: UITextView
//            }
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
//        }
//    }
//}
//
//struct AnnotationDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnnotationDetailView()
//    }
//}
//
//// --------------------------------------------------------------------------------
//// CreateAnnotationViewController
//// --------------------------------------------------------------------------------
//struct CreateAnnotationView: View {
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .topLeading) {
//                //TextField("", text: $bindingVariable)
//                //TextField("", text: $bindingVariable)
//
//                Button(action: {}) {
//                    Text("Scan Target Text")
//                        .frame(width: 414, height: 58, alignment: .center)
//                }
//                .aspectRatio(contentMode: .fill)
//                .font(.system(size: 45))
//                .offset(x: 0, y: 138)
//
//                // TODO: Unsupported element class: UITextView
//                // TODO: Unsupported element class: UITextView
//                //DatePicker(selection: $selectedDate, in: dateClosedRange, displayedComponents: .date, label: { Text("Due Date") })
//
//                Button(action: {
//                    //addPressedWithSender()
//                }) {
//                    Text("Create")
//                        .frame(width: 414, height: 78, alignment: .center)
//                }
//                .aspectRatio(contentMode: .fill)
//                .font(.system(size: 55))
//                .offset(x: 0, y: 730)
//            }
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
//        }
//    }
//}
//
//struct CreateAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateAnnotationView()
//    }
//}
//
//// --------------------------------------------------------------------------------
//// StatusViewController
//// --------------------------------------------------------------------------------
//struct StatusView: View {
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .topLeading) {
//                // TODO: Unsupported element class: UIVisualEffectView
//
//                Button(action: {
//                    //restartExperience()
//                }) {
//                    Image(systemName: "restart")
//                        .frame(width: 44, height: 59, alignment: .bottomLeading)
//                }
//                .aspectRatio(contentMode: .fill)
//                .foregroundColor(Color.white)
//                .offset(x: 370, y: 44)
//            }
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
//        }
//    }
//}
//
//struct StatusView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatusView()
//    }
//}
//
//// --------------------------------------------------------------------------------
//// OCRViewController
//// --------------------------------------------------------------------------------
//struct OCRView: View {
//    var body: some View {
//        struct ContentView: View {
//            var body: some View {
//                GeometryReader { geometry in
//                    ZStack(alignment: .topLeading) {
//                        Text("Snap/upload a clear picture of your poem then edit below. Tap outside of the text box once your sweet nothings are complete.")
//                            .font(.custom("BradleyHandITCTT-Bold", size: 16))
//                            .multilineTextAlignment(.center)
//                            .foregroundColor(Color(white: 1.0))
//                            .offset(x: 26, y: 50)
//                            .frame(width: 362, height: 60)
//
//                        Button(action: {
//                            //takePhoto()
//                        }) {
//                            Text("Snap/Upload Image")
//                                .frame(width: 312, height: 40, alignment: .center)
//                        }
//                        .aspectRatio(contentMode: .fill)
//                        .font(.custom("BradleyHandITCTT-Bold", size: 22))
//                        .offset(x: 51, y: 502)
//
//                        // TODO: Unsupported element class: UITextView
//                        // TODO: Unsupported element class: UIActivityindicatorView
//                    }
//                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
//                }
//            }
//        }
//
//        struct ContentView_Previews: PreviewProvider {
//            static var previews: some View {
//                ContentView()
//            }
//        }
//    }
//}
//
//struct OCRView_Previews: PreviewProvider {
//    static var previews: some View {
//        OCRView()
//    }
//}
//
//// --------------------------------------------------------------------------------
//// UINavigationController
//// --------------------------------------------------------------------------------
//NavigationView {
//    Spacer()    // TODO: replace with the actual content
//}
