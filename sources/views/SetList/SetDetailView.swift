//
//  SetDetailView.swift
//  BrickSet
//
//  Created by Work on 03/05/2020.
//  Copyright © 2020 LEOLELEGO. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct SetDetailView: View {
    
    @ObservedObject var set : LegoSet
    @State var additionalImages = [LegoSetImage]()
    @State var instructions = [LegoInstruction]()
    
    var body: some View {
        ScrollView( showsIndicators: false){
            makeThumbnail()
            makeThemes()
            Spacer()
            makeHeader()
            Divider()
            makeButtons()
            makeImages()
            makeInstructions()
        }
            .onAppear {
                
                API.additionalImages(setID: self.set.setID) { items in
                    self.additionalImages = items
                }
                if self.set.instructionsCount > 0{
                    API.instructions(setID: self.set.setID) { items in
                        self.instructions = items

                    }
                }
                
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing: ShareNavButton(items: [set.bricksetURL]))
        .navigationBarHidden(false)

    }
    
    func makeThumbnail() -> some View {
        ZStack(alignment: .bottomTrailing){
            WebImage(url: URL(string:self.set.image.imageURL ?? "")).resizable().aspectRatio(contentMode: .fit).clipped()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 400, alignment: .center)
                .background(Color.white)
        }

    }
    func makeThemes() -> some View{
        HStack(spacing: 8){
            
            Button(action: {
            }, label: {
                RoundedText(text: set.theme)
            })
            if set.subtheme != nil {
                Text(">")
                Button(action: {
                }, label: {
                    RoundedText(text: set.subtheme!)
                })
            }
            Spacer()
            Button(action: {
            }, label: {
                RoundedText(text: "\(set.year)")
            })
        }.padding(.horizontal)
    }
    func makeHeader() -> some View{
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                Text( set.number+" ").font(.lego(size: 32)).foregroundColor(.black)
                    + Text(set.name).font(.largeTitle).bold().foregroundColor(.black)
                Spacer()
            }
            .foregroundColor(Color.backgroundAlt)
            .padding(.vertical,8).padding(.horizontal,6)
            .background(BackgroundImageView(imagePath: set.image.imageURL)).clipped().modifier(RoundedShadowMod())
            .foregroundColor(Color.background)
            
            HStack(alignment: .bottom){
                Text("\(set.pieces ?? 0)").font(.headline)
                Image.brick(height:26)
                Text("\(set.minifigs ?? 0)").font(.headline)
                Image.minifig_head(height:26)
                Spacer()
                Text(set.price ?? "").font(.title).bold()
            }
        }.padding(.horizontal)
            .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
    }
    func makeButtons() -> some View {
        CollectionItemView(set: set).padding(.horizontal)
    }
    
    func makeImages() -> some View{
        Group {
            if additionalImages.count > 0 {
                VStack(alignment: .leading){
                    Text("sets.images").font(.title).bold().padding()
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack(spacing: 16){
                            ForEach(additionalImages, id: \.thumbnailURL){ image in
                                WebImage(url: URL(string:image.thumbnailURL ?? "")).resizable().scaledToFill().frame(width: 100, height: 100)
                                    .modifier(RoundedShadowMod())
                            }
                        }.padding(.horizontal,32)
                    }.frame(height: 100).padding(.horizontal, -16)
                    
                }
            } else {
                EmptyView()
            }
        }
        
    }
    func makeInstructions() -> some View{
        Group {
            if self.instructions.first != nil {
                NavigationLink(destination: LegoPDFView(stringURL: self.instructions.first!.URL)) {
                    Text("sets.instruction")
                        .fontWeight(.bold).foregroundColor(Color.black)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .mask(RoundedRectangle(cornerRadius: 12))
                        .padding()
                    
                }
                
            } else {
                EmptyView()
            }
        }
        
    }
    
}

//let previewCollection = UserCollection(json: "SampleSets.json")
//
//struct SetDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetDetailView(set:previewCollection.sets.first!).previewDevice(PreviewDevice(rawValue: "iPhone 11"))
//    }
//}