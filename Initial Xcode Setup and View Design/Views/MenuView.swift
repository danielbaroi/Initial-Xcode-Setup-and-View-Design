import SwiftUI
import AVKit
import UIKit
import AVFoundation




struct MenuView: View {
    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                HomeView(selectedTab: $selectedTab)
                    .background(Color(red: 1.0, green: 1.0, blue: 0.8))
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                
                NavigationView {
                    OrderView()
                }
                .background(Color(red: 1.0, green: 1.0, blue: 0.8))
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Order")
                }
                .tag(1)
                
                RewardsView()
                    .background(Color(red: 1.0, green: 1.0, blue: 0.8))
                    .tabItem {
                        Image(systemName: "gift")
                        Text("Rewards")
                    }
                    .tag(2)
                
                MoreView()
                    .background(Color(red: 1.0, green: 1.0, blue: 0.8))
                    .tabItem {
                        Image(systemName: "ellipsis")
                        Text("More")
                    }
                    .tag(3)
            }
        }
    }
}


struct HomeView: View {
    @Binding var selectedTab: Int
    @State private var boxHeight: CGFloat = 0.75
    @State private var player = AVPlayer()
    @State private var showNutritionalInfo = false
    @State private var selectedCookie: String?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    // Video Player (unchanged)
                    VideoPlayer(player: player)
                        .frame(height: geometry.size.height * boxHeight)
                        .padding(.horizontal, -20)
                        .padding(.vertical, -30)
                        .onAppear {
                            if let videoURL = Bundle.main.url(forResource: "EOSC-reel", withExtension: "mp4") {
                                player = AVPlayer(url: videoURL)
                                player.play()
                            }
                        }
                        .animation(.easeInOut, value: boxHeight)

                    // Cookie of the Month Section
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Cookie of the Month")
                            .font(.system(size: 35, weight: .bold))
                            .padding(.horizontal, -5)
                            .padding(.vertical, 10)

                        CookieButton(cookieName: "Strawberry")
                        CookieButton(cookieName: "Confetti")

                        // Order Now Button
                        Button(action: {
                            selectedTab = 1 // Switch to Order Tab
                        }) {
                            Text("Order Now")
                                .font(.system(size: 20, weight: .bold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 20)
                }
                .padding()
                .padding(.bottom, 100)
                .background(Color(red: 1.0, green: 1.0, blue: 0.8))
            }
            .background(Color(red: 1.0, green: 1.0, blue: 0.8))
            .ignoresSafeArea()
            .sheet(isPresented: $showNutritionalInfo) {
                NutritionalInfoView(cookieName: selectedCookie ?? "")
            }
        }
    }
    
    private func CookieButton(cookieName: String) -> some View {
        VStack(alignment: .leading) {
            Button(action: {
                selectedTab = 1 // Switch to Order Tab
            }) {
                Text(cookieName)
                    .font(.system(size: 25, weight: .bold))
                Text("Cookie")
                    .font(.system(size: 25, weight: .bold))
            }
            .foregroundColor(.black)
            
            Button(action: {
                selectedCookie = cookieName
                showNutritionalInfo = true
            }) {
                Text("Learn More")
                    .font(.system(size: 15))
                    .foregroundColor(.blue)
            }
            .padding(.top, 5)
        }
        .padding(.horizontal)
    }
}
struct NutritionalInfoView: View {
    let cookieName: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Text("Nutritional Information for \(cookieName) Cookie")
                    .font(.headline)
                    .padding()
                
                // Add your nutritional information here
                Text("Calories: 250")
                Text("Fat: 12g")
                Text("Carbs: 33g")
                Text("Protein: 3g")
                
                Spacer()
            }
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}





struct OrderView: View {
    @State private var selectedBatter = ""
    @State private var selectedMixIns: [String] = []
    @State private var showCustomizationForm = false

    let batters = ["Chocolate Chip", "Peanut Butter", "Sugar Cookie"]
    let mixIns = [
        "Semi-Sweet Chocolate", "White Chocolate", "M&M’s", "Andes Mints",
        "Peanut Butter", "Marshmallows", "Golden Grahams", "Heath Bar Bits",
        "Oreos", "Walnuts", "Pecans", "Rainbow Sprinkles", "Caramel",
        "Pretzels", "Potato Chips", "Almond Flavoring", "Peppermint Flavoring",
        "Espresso", "Banana Flavoring", "Coconut", "Pineapple Flavoring",
        "Lemon Flavoring", "Strawberries", "Raspberries", "Mango Flavoring",
        "Raisins", "Blueberries", "Cinnamon", "Cinnamon and Sugar Coating",
        "Apples", "Butterscotch Chips"
    ]

    var body: some View {
           GeometryReader { geometry in
               ScrollView {
                   VStack(spacing: 20) {
                       // Image inside the black box
                       Image("multiplecookie") // Replace with the actual image name
                           .resizable()
                           .scaledToFill()
                           .frame(height: geometry.size.height * 0.6)
                           .clipped()

                       // "Customize Your Perfect Cookie" section below the image
                       VStack(spacing: 20) {
                           Text("CUSTOMIZE YOUR PERFECT COOKIE!")
                               .font(.system(size: 35, weight: .bold))
                               .multilineTextAlignment(.center)
                               .frame(maxWidth: .infinity, alignment: .leading)
                               .padding(.horizontal, 20)
                               .padding(.vertical, 10)

                           // Start Baking Button
                           Button(action: {
                               showCustomizationForm.toggle()
                           }) {
                               Text("Start Baking")
                                   .font(.system(size: 20, weight: .bold))
                                   .frame(width: geometry.size.width * 0.8, alignment: .center)
                                   .padding()
                                   .background(Color.black)
                                   .foregroundColor(.white)
                                   .cornerRadius(10)
                           }
                           .frame(maxWidth: .infinity, alignment: .leading)
                       }
                       .frame(maxWidth: .infinity)
                       .padding(.top, 20)
                       .padding(.horizontal, 20)
                       .padding(.vertical, 20)

                    // Show Customization Form if toggled
                    if showCustomizationForm {
                        VStack(spacing: 20) {
                            Text("Custom Cookie")
                                .font(.system(size: 25, weight: .bold))
                                .padding(.top)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()

                            // Batter Type Picker
                            VStack(alignment: .leading) {
                                Text("Batter Type")
                                    .font(.headline)
                                    .padding(.bottom, 5)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                

                                ForEach(batters, id: \.self) { batter in
                                    Toggle(isOn: Binding(
                                        get: { selectedBatter == batter },
                                        set: { isSelected in
                                            if isSelected {
                                                selectedBatter = batter
                                            } else {
                                                selectedBatter = ""
                                            }
                                        }
                                    )) {
                                        Text(batter)
                                    }
                                    .toggleStyle(CheckboxToggleStyle()) // Use Checkbox for batter selection
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top)

                            // Mix-ins Selection
                            VStack(alignment: .leading) {
                                Text("Cookie Mix-ins")
                                    .font(.headline)
                                    .padding(.bottom, 5)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()

                                ForEach(mixIns, id: \.self) { mixIn in
                                    Toggle(isOn: Binding(
                                        get: { selectedMixIns.contains(mixIn) },
                                        set: { isSelected in
                                            if isSelected {
                                                if selectedMixIns.count < 3 {
                                                    selectedMixIns.append(mixIn)
                                                }
                                            } else {
                                                selectedMixIns.removeAll { $0 == mixIn }
                                            }
                                        }
                                    )) {
                                        Text(mixIn)
                                    }
                                    .toggleStyle(CheckboxToggleStyle()) // Use Checkbox for mix-ins
                                    .disabled(!selectedMixIns.contains(mixIn) && selectedMixIns.count >= 3)
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 100) // Avoid overlap with bottom content
                .background(Color(red: 1.0, green: 1.0, blue: 0.8)) // Consistent background color
            }
            .background(Color(red: 1.0, green: 1.0, blue: 0.8))
            .ignoresSafeArea()
        }
    }
}


struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
        }
    }
}




// RewardsView with similar layout

struct RewardsView: View {

    var body: some View {

        GeometryReader { geometry in

            ScrollView {

                VStack(spacing: 20) {

                    // Add your content here for Rewards tab (Images, Texts, etc.)

                    Text("Rewards Tab Content")

                        .font(.largeTitle)

                        .padding()

                }

                .padding()

                .padding(.bottom, 100) // Avoid overlap with TabView

                .background(Color(red: 1.0, green: 1.0, blue: 0.8)) // Background color for scrolling content

            }

            .ignoresSafeArea()

            .safeAreaInset(edge: .bottom) {

                Color.clear.frame(height: 50) // Space for TabView

            }

        }

    }

}



// MoreView

struct MoreView: View {
    @State private var player: AVPlayer?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    // Add your content here for More tab (Images, Texts, etc.)
                    Text("More Tab Content")
                        .font(.largeTitle)
                        .padding()

                    // Video Player Section
                    if let player = player {
                        VideoPlayer(player: player)
                            .frame(height: geometry.size.height * 0.4) // Adjust height as needed
                            .onAppear {
                                player.play() // Start playing the video when it appears
                            }
                    } else {
                        Text("Video not available")
                    }
                }
                .padding()
                .padding(.bottom, 100) // Avoid overlap with TabView
                .background(Color(red: 1.0, green: 1.0, blue: 0.8)) // Background color for scrolling content
                .onAppear {
                    setupVideoPlayer()
                }
            }
            .ignoresSafeArea()
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 50) // Space for TabView
            }
        }
    }

    private func setupVideoPlayer() {
        if let videoPath = Bundle.main.path(forResource: "EOSC-reel", ofType: "mp4") {
            let videoURL = URL(fileURLWithPath: videoPath)
            player = AVPlayer(url: videoURL)
        } else {
            print("Video file not found.")
        }
    }
}




#Preview {

    MenuView()

}
