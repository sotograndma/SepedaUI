//
//  ContentView.swift
//  SepedaUI
//
//  Created by Dzaky Saputra on 03/02/21.
//

import SwiftUI

//Model Data
struct ProductModel : Identifiable{
    let id: Int
    let namaProduk: String
    let fotoProduk: String
    let hargaProduk: Int
    let lokasi: String
    let ratingCount: Int
    let jumlahRating: Int
    
    init(id: Int, namaproduk: String, fotoproduk: String, hargaproduk: Int, lokasi: String, ratingcount: Int, jumlahrating: Int) {
        
        self.id = id
        self.namaProduk = namaproduk
        self.fotoProduk = fotoproduk
        self.hargaProduk = hargaproduk
        self.lokasi = lokasi
        self.ratingCount = ratingcount
        self.jumlahRating = jumlahrating
    }
}

struct ContentView: View {
    
    let data : [ProductModel] = [
        ProductModel(id: 1, namaproduk: "Polygon Xtrada", fotoproduk: "foto1", hargaproduk: 2000000, lokasi: "Kab.Banyumas", ratingcount: 4, jumlahrating: 56),
        ProductModel(id: 2, namaproduk: "Polygon Heist", fotoproduk: "foto2", hargaproduk: 3000000, lokasi: "Kab.Bogor", ratingcount: 5, jumlahrating: 50),
        ProductModel(id: 3, namaproduk: "Polygon Monarch", fotoproduk: "foto3", hargaproduk: 5000000, lokasi: "Kab.Brebes", ratingcount: 4, jumlahrating: 56),
        ProductModel(id: 4, namaproduk: "United Detroit", fotoproduk: "foto4", hargaproduk: 9000000, lokasi: "Kab.Pekalongan", ratingcount: 5, jumlahrating: 56),
        ProductModel(id: 5, namaproduk: "United Miami", fotoproduk: "foto5", hargaproduk: 9000000, lokasi: "Kab.Pamulang", ratingcount: 3, jumlahrating: 56),
        ProductModel(id: 6, namaproduk: "United Patrol", fotoproduk: "foto6", hargaproduk: 2000000, lokasi: "Kab.Banyumas", ratingcount: 4, jumlahrating: 56),
        ProductModel(id: 7, namaproduk: "Exotic M56", fotoproduk: "foto7", hargaproduk: 6000000, lokasi: "Kab.Bogor", ratingcount: 5, jumlahrating: 50),
        ProductModel(id: 8, namaproduk: "Exotic J98", fotoproduk: "foto8", hargaproduk: 2000000, lokasi: "Kab.Brebes", ratingcount: 4, jumlahrating: 56),
        ProductModel(id: 9, namaproduk: "Genio Xtrada", fotoproduk: "foto9", hargaproduk: 8000000, lokasi: "Kab.Pekalongan", ratingcount: 5, jumlahrating: 56),
        ProductModel(id: 10, namaproduk: "Pacific M898", fotoproduk: "foto10", hargaproduk: 2000000, lokasi: "Kab.Pamulang", ratingcount: 4, jumlahrating: 56)
    ]
    
    @State var jumlahkeranjang: Int = 0
    
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(data) { row in
                    VStack(spacing:10) {
                        Product(data: row, jumlahproduk: self.$jumlahkeranjang)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Sepeda MTB")
            .navigationBarItems(
                trailing:
                HStack(spacing: 20){
                    Button(action: {print()})
                    {
                        Image(systemName: "person.fill")
                    }
                    
                    keranjangView(jumlah: $jumlahkeranjang)
                }
            )
        }
        .accentColor(Color.secondary)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct keranjangView : View {
    @Binding var jumlah: Int
    
    var body : some View{
        ZStack{
            Button(action: {print("Oke")}){
                Image(systemName: "cart.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            
            Text("\(jumlah)")
                .foregroundColor(Color.white)
                .frame(width: 10, height: 10)
                .font(.body)
                .padding(5)
                .background(Color.red)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .offset(x:10,y:-10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Product: View {
    let data: ProductModel
    
    @Binding var jumlahproduk : Int
    
    var body: some View{
        VStack(alignment: .leading){
            //foto
            ZStack(alignment:.topTrailing){
                Image(self.data.fotoProduk)
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(height:250)
                    .clipped()
                
                Button(action: {print("OK")}){
                    Image(systemName: "heart")
                        .padding()
                        .foregroundColor(Color.red)
                }
            }
            
            Text(self.data.namaProduk)
                .font(.title)
                .bold()
                .padding(.leading)
                .padding(.trailing)
            
            Text("Rp. \(self.data.hargaProduk)")
                .font(.title)
                .foregroundColor(Color.red)
                .bold()
                .padding(.leading)
                .padding(.trailing)
            
            HStack{
                Image(systemName: "mappin.circle")
                Text(self.data.lokasi)
            }
            .padding(.leading)
            .padding(.trailing)
            
            HStack{
                HStack{
                    ForEach(0..<self.data.ratingCount){
                        items in
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing)
            
            tambahKeranjang(jumlah: $jumlahproduk)
        }
        .background(Color("warna"))
        .cornerRadius(15)
    }
}

//button tambah keranjang
struct tambahKeranjang : View{
    //buat binding data
    @Binding var jumlah: Int
    
    var body : some View {
        Button(action: {self.jumlah += 1}){
            HStack{
                Spacer()
                HStack{
                    Image(systemName: "cart")
                    Text("Tambah ke Keranjang")
                        .font(.callout)
                        .padding()
                }
                Spacer()
            }
        }
        .background(Color.green)
        .foregroundColor(Color.white)
        .cornerRadius(10)
        .padding()
    }
}
