# 100DaysOfSwiftUI

Projects from the [100 Days of SwiftUI](https://www.hackingwithswift.com/100/swiftui) course by Paul Hudson ([@twostraws](https://github.com/twostraws))

The course is divided into `Projects` and `Milestones`. `Projects` are meant to teach iOS cocepts, techniques and frameworks.
**Every 3 projects**, a milestone is reached. `Milestones` are challenges that use the concepts learned in the previous 3 projects. For example, after `Project 3` comes `Milestone 1`.

## Course Content

| Projects & Topics | Screenshots |
| -----------------  | :---------: |
| **Project 1:** *[WeSplit](WeSplit)*<br><sub>_Structure of SwiftUI projects<br>**Protocols:** `View`, and `PreviewProvider`<br>**Views:** `NavigationView`, `Form`, `Group`, `Section`, `Text`, `TextField`, `Picker`, and `ForEach`<br>**Property Wrapper:** `@State` and `$` prefix operator for binding<br><br>**Concepts learned through research:**<br>– `HStack`, and `Spacer` views_<br><br></sub> | ![Screenshots](WeSplit/Screenshots/Thumbnails/Combined.png) |
| **Challenge day:** *[UnitConverter](UnitConverter)*<br><sub>_**Concepts learned through research:**<br>– The `id` parameter of `ForEach` to identify each element in the collection uniquely<br>– The `Binding` property wrapper to provide a custom setter and getter to the Picker view<br>– `Button` view_</sub> | ![Screenshots](UnitConverter/Screenshots/Thumbnails/Combined.png) |
| **Project 2:** *[GuessTheFlag](GuessTheFlag)*<br><sub>_**Views:** `HStack`, `VStack`, `ZStack`, `Spacer`, `Image`, `Button`, `Alert`, `Color`, `LinearGradient`, `RadialGradient`, `AngularGradient`_<br><br></sub> | ![Screenshots](GuessTheFlag/Screenshots/Thumbnails/Combined.png) |
| **Project 3:** *[ViewsAndModifiers](ViewsAndModifiers)*<br><sub>_(Technique Project)<br><br>– Fundamentals of `Views`, and `ViewModifiers`<br>– Conditional modifiers<br>– Environment modifiers<br>– View composition<br>– Custom modifiers<br>– Custom containers using `@ViewBuilder` and `@escaping` closure_</sub> | ![Screenshots](ViewsAndModifiers/Screenshots/Thumbnails/Combined.png) |
| **Milestone 1:** *[RockPaperScissors](RockPaperScissors)*<br><sub>_Applies concepts learned in Projects 1-3_</sub> | ![Screenshots](RockPaperScissors/Screenshots/Thumbnails/Combined.png) |
| **Project 4:** *[BetterRest](BetterRest)*<br><sub>_**Views:** `DatePicker`, `Stepper`<br>**Modifiers:** `navigationBarItems()`<br>Machie Learning (`CoreML`, and `CreateML`)<br>`Date`, `DateFormatter`, `DateComponents`_</sub> | ![Screenshots](BetterRest/Screenshots/Thumbnails/Combined.png) |
| **Project 5:** *[WordScramble](WordScramble)*<br><sub>_**Views:** `List`<br>**Modifiers:** `onAppear()`<br>`Bundle`, `fatalError()`, `UITextChecker`_</sub> | ![Screenshots](WordScramble/Screenshots/Thumbnails/Combined.png) |
| **Project 6:** *[Animations](Animations)*<br><sub>_(Technique Project)<br><br>**Modifiers:** `animation`, `scaleEffect`, `rotation3DEffect`, `rotationEffect`, `offset`, `gesture`, `clipped`, `transition`<br>**Other:** `Animation`, `withAnimation`, `DragGesture`<br><br>**Concepts learned through research:**<br>– `AnyView`<br>– Using `_` (underscore) before variable (e.g.: `_variable`) to initialize `State` variables_</sub> | ![Screenshots](Animations/Screenshots/Thumbnails/Combined.png) |
| **Milestone 2:** *[MultiplicationTables](MultiplicationTables)*<br><sub>_Applies concepts learned in Projects 4-6<br><br>**Concepts learned through research:**<br>–The `GeometryReader` view to set frame sizes as a percentage of the screen<br>– The `sheet` view modifier to show another view modally<br>– The `UIViewRepresentable` protocol to wrap UIKit views and show them in SwiftUI_</sub> | ![Screenshots](MultiplicationTables/Screenshots/Thumbnails/Combined.png) |
| **Project 7:** *[iExpense](iExpense)*<br><sub>_**Property Wrappers:** `@ObservedObject`, `@Published`, `@Environment(\.presentationMode)`<br>**ViewModifiers:** `sheet()`, `onDelete()`<br>**Other:** `Identifiable`, `ObservableObject`, `UserDefaults`, `Codable`_</sub> | ![Screenshots](iExpense/Screenshots/Thumbnails/Combined.png) |
| **Project 8:** *[Moonshot](Moonshot)*<br><sub>_**Views:** `GeometryReader`, `ScrollView`, `NavigationLink`<br>**ViewModiers:** `resizable`, `scaledToFit`, `buttonStyle`, `layoutPriority`_</sub> | ![Screenshots](Moonshot/Screenshots/Thumbnails/Combined.png) |
| **Project 9:** *[Drawing](Drawing)*<br><sub>_(Technique Project)<br><br>**Views:** `Path`, `Shape`, `InsettableShape`<br>**ViewModifiers:** `strokeBorder`, `drawingGroup`, `blendMode`, `colorMultiply`, `saturation`<br>**Other:** `StrokeStyle`, `CGAffineTransform`, `ImagePaint`, `animatableData`, `AnimatablePair`_</sub> | ![Screenshots](Drawing/Screenshots/Thumbnails/Combined.png) |
| **Milestone 3:** *[HabitTracker](HabitTracker)*<br><sub>_Applies concepts learned in Projects 7-9_</sub> | ![Screenshots](HabitTracker/Screenshots/Thumbnails/Combined.png) |
| **Project 10:** *[CupcakeCorner](CupcakeCorner)*<br><sub>_– Manually Encoding and Decoding an `ObservableObject` using `CodingKey`<br>– Networking using `URLRequest` and `URLSession`_</sub> | ![Screenshots](CupcakeCorner/Screenshots/Thumbnails/Combined.png) |
| **Project 11:** *[Bookworm](Bookworm)*<br><sub>_**Property Wrappers:** `@FetchRequest`, `@Environment(\.horizontalSizeClass)`<br>**Views:** `AnyView`<br>**Other:** `Core Data` (`NSManagedObject`, `NSManagedObjectContext`, `NSSortDescriptor`)_</sub> | ![Screenshots](Bookworm/Screenshots/Thumbnails/Combined.png) |
| **Project 12:** *[CoreDataProject](CoreDataProject)*<br><sub>_(Technique Project)<br><br>Entity codegen (Manual / Class / Category), constraints, relationships<br>`NSPredicate`, `NSMergePolicy`_</sub> | ![Screenshots](CoreDataProject/Screenshots/Thumbnails/Combined.png) |
| **Milestone 4:** *[Friendface](Friendface)*<br><sub>_Applies concepts learned in Projects 10-12_<br><br>**Concepts learned through research:**<br>– How to decode JSON as a `NSManagedObject` object by passing the `NSManagedObjectContext` in the `userInfo` property of `Decoder`</sub> | ![Screenshots](Friendface/Screenshots/Thumbnails/Combined.png) |
| **Project 13:** *[Instafilter](Instafilter)*<br><sub>_– CoreImage Framework: `CIFilter`, `CIContext`<br>– Conversion between: `CIImage`, `CGImage` and `UIImage`<br>– How to integrate UIKit in SwiftUI by using `UIViewControllerRepresentable`<br>– How to pick an image: `UIImagePickerController`, `UIImagePickerControllerDelegate`<br>– `ActionSheet` and Custom Bindings_</sub> | ![Screenshots](Instafilter/Screenshots/Thumbnails/Combined.png) |
| **Project 14:** *[BucketList](BucketList)*<br><sub>_– Writing data to the Documents directory using `FileManager`<br>– MapKit (`MKMapView`, `MKPinAnnotationView`)<br>– Biometrics authentication (Touch ID and Face ID) using `LocalAuthentication`<br>– Adding `Comparable` conformance to custom types_</sub> | ![Screenshots](BucketList/Screenshots/Thumbnails/Combined.png) |
| **Project 15:** *[Accessibility](Accessibility)*<br><sub>_(Technique Project)<br><br>– Identifying views with useful labels<br>– Hiding and grouping accessibility data<br>– Reading the value of controls_</sub> | ![Screenshots](Accessibility/Screenshots/Thumbnails/Combined.png) |
| **Milestone 5:** *[MeetupContacts](MeetupContacts)*<br><sub>_Applies concepts learned in Projects 13-15_<br><br></sub> | ![Screenshots](MeetupContacts/Screenshots/Thumbnails/Combined.png) |