//
//  ARViewController.swift
//  AnnotateAR
//
//  Created by Skyler Brown on 7/16/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import Foundation
import ARKit
import SceneKit


class ARViewController: UIViewController, ARSCNViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

 /*
    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    var cameraUIImage: UIImage!
    var cameraARRefImage: ARReferenceImage!
    var bookText: UITextView!
    
    /// The view controller that displays the status and "restart experience" UI.
    lazy var statusViewController: StatusViewController = {
        return children.lazy.compactMap({ $0 as? StatusViewController }).first!
    }()
    
    /// A serial queue for thread safety when modifying the SceneKit node graph.
    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
        ".serialSceneKitQueue")
    
    /// Convenience accessor for the session owned by ARSCNView.
    var session: ARSession {
        return sceneView.session
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.observeQuery()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.ready()

        sceneView.delegate = self
        sceneView.session.delegate = self

        // Hook up status view controller callback(s).
        statusViewController.restartExperienceHandler = { [unowned self] in
            self.restartExperience()
        }
    }
    
    private func bindViewModel() {
    viewModel.didChangeData = { [weak self] data in
        guard let strongSelf = self else { return }
    /*    if data.isUserACollector {
            strongSelf.disableButton()
        }
*/
        let annotation = data.annotation
        // TODO: get the user from a user id
        strongSelf.authorLabel.text = annotation.owner
        strongSelf.bookLabel.text = annotation.book
        strongSelf.bodyLabel.text = annotation.body
        strongSelf.pageLabel.text = "(p\(annotation.page))"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        strongSelf.dateLabel.text = dateFormatter.string(from: annotation.date.dateValue())
        
        strongSelf.tableViewAdapter.update(with: data.collectors)
        strongSelf.collectorsTableView.reloadData()
       
        }
    }
    @IBAction func getPicture(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()

        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // Assign the camera pic photo to global cameraImage variable
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        cameraUIImage = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        addARReferenceImageFromCamera()
    }
    
    // Convert CIImage to ARReferenceImage
    func addARReferenceImageFromCamera () {
        
        guard let imageToCIImage = CIImage(image: cameraUIImage),
            let cgImage = convertCIImageToCGImage(inputImage: imageToCIImage) else { return }
        let arImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.22) // assuming A4 page
        
        arImage.name = "TheTextbookPage"
        cameraARRefImage = arImage
        // arConfig.trackingImages = [arImage]
    }
    
    // Convert CIImage to CGI image
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
            return cgImage
        }
        return nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Prevent the screen from being dimmed to avoid interuppting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true
        
        if cameraARRefImage != nil {
            
        // Start the AR experience
        resetTracking()
            
        } else{("error") }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        session.pause()
    }

    // MARK: - Session management (Image detection setup)
    
    /// Prevents restarting the session while a restart is in progress.
    var isRestartAvailable = true

    /// Creates a new AR configuration to run on the `session`.
    /// - Tag: ARReferenceImage-Loading
    func resetTracking() {
        
        
        guard let referenceImages = cameraARRefImage  else { (fatalError("wat \(cameraARRefImage)"))/*  ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {

            fatalError("Missing expected asset catalog resources. \(cameraARRefImage)") */
        }
    
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = [referenceImages]
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

        statusViewController.scheduleMessage("Look around to detect images", inSeconds: 7.5, messageType: .contentPlacement)
    }

    private var anchorLabels = [UUID: String]()
    
    // MARK: - ARSCNViewDelegate (Image detection results)
    /// - Tag: ARImageAnchor-Visualizing
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        updateQueue.async {
            
            // Create a plane to visualize the initial position of the detected image.
            let plane = SCNPlane(width: referenceImage.physicalSize.width,
                                 height: referenceImage.physicalSize.height)
            let planeNode = SCNNode(geometry: plane)
            planeNode.opacity = 0.25
            
            /*
             `SCNPlane` is vertically oriented in its local coordinate space, but
             `ARImageAnchor` assumes the image is horizontal in its local space, so
             rotate the plane to match.
             */
            planeNode.eulerAngles.x = -.pi / 2
            
            /*
             Image anchors are not tracked after initial detection, so create an
             animation that limits the duration for which the plane visualization appears.
             */
            planeNode.runAction(self.imageHighlightAction)
            
            // Add the plane visualization to the scene.
            node.addChildNode(planeNode)
            
            // Create text node for notes
            let text = SCNText(string: self.bookText, extrusionDepth: 1)
            let textNode = SCNNode(geometry: text)
            textNode.scale = SCNVector3(0.003,0.003,0.003)
            textNode.eulerAngles.x = -.pi / 2
            textNode.position = SCNVector3(CGFloat(planeNode.position.x - 0.06), CGFloat(planeNode.position.y), CGFloat(planeNode.position.z - 0.1))
            node.addChildNode(textNode)
        }
        

        DispatchQueue.main.async {
            let imageName = referenceImage.name ?? ""
            self.statusViewController.cancelAllScheduledMessages()
            self.statusViewController.showMessage("Detected image “\(imageName)”")
        }
    }

    var imageHighlightAction: SCNAction {
        return .sequence([
            .wait(duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOpacity(to: 0.15, duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            /* .fadeOut(duration: 0.5),
            .removeFromParentNode()
            */
        ])
    }
        // MARK: - Tap gesture handler & ARSKViewDelegate
        
        // Labels for classified objects by ARAnchor UUID
    

        // When the user taps, add an anchor associated with the current classification result.
        /// - Tag: PlaceLabelAtLocation
    @IBAction func PlaceLabelAtLocation(_ sender: UITapGestureRecognizer) {
        let hitLocationInView = sender.location(in: sceneView)
                let hitTestResults = sceneView.hitTest(hitLocationInView, types: [.featurePoint, .estimatedHorizontalPlane])
                if let result = hitTestResults.first {
                    
                    // Add a new anchor at the tap location.
                    // S - result.worldTransform is the 4x4 sim coordinates of the object
                    let anchor = ARAnchor(transform: result.worldTransform)
                    sceneView.session.add(anchor: anchor)
                    
        // ---This is where object text is turned into anchor text---
                    
                    // Track anchor ID to associate text with the anchor after ARKit creates a corresponding SKNode.
                    // S - Changed identifierString to translateText
                    anchorLabels[anchor.identifier] = "enter notes here"

    }
    */
    
/*
        // When an anchor is added, provide a SpriteKit node for it and set its text to the classification label.
        /// - Tag: UpdateARContent
        func view(_ view: ARSKView, didAdd node: SKNode, for anchor: ARAnchor) {
            guard let labelText = anchorLabels[anchor.identifier] else {
                fatalError("missing expected associated label for anchor")
            }
            
            let label = TemplateLabelNode(text: labelText)
            // S - Makes position of anchor text label node slightly higher than the touch point
            label.position = CGPoint(x: label.position.x, y: (label.position.y + 0.03))
            node.addChild(label)

        }*/
}
