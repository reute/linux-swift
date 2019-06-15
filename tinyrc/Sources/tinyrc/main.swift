
    import Foundation
    
    let win_w = 8; // image width
    let win_h = 8; // image height

    var framebuffer : [UInt32] = Array(repeating: 255, count: win_w * win_h)

    func pack_color(_ r: UInt8, _ g: UInt8, _ b: UInt8, a: UInt8 = 255) -> UInt32 {
        return (UInt32(a))<<24 + (UInt32(b))<<16 + (UInt32(g))<<8 + (UInt32(r))
    }

    func unpack_color(_ color: UInt32) -> [UInt8] {
        // let r = UInt8((color >>  0) & 255);
        // let g = (color >>  8) & 255;
        // let b = (color >> 16) & 255;
        // let a = (color >> 24) & 255;
        let r = UInt8((color >>  0) & 255);
        let g = UInt8((color >>  8) & 255);
        let b = UInt8((color >> 16) & 255);
        let a = UInt8((color >> 24) & 255);

        return [r,g,b]
    }

    func drop_ppm_image(_ filename: String, _ image: [UInt32], _ w: Int, _ h: Int) {         
        assert(image.count == w * h, "image has wrong size")           

        //let path = FileManager.default.currentDirectoryPath 
          
        let fileURL = URL(fileURLWithPath: filename)
        //let fileURL = getDocumentsDirectory().appendingPathComponent(filename)   
        print("\(fileURL)")
        //let header = "P6\n\(w) \(h)\n255\n"
        var byteArray = [UInt8]()
        //print(image)
   
        do {
            //try header.write(to: fileURL, atomically: false, encoding: .utf8)
            for value in image {
                byteArray += unpack_color(value)             
            }
            print(byteArray)
            var headerData: Data = "P6\n\(w) \(h)\n255\n".data(using: .utf8)!            
            //let mdata  = Data(bytes: byteArray)  
            headerData.append(contentsOf: byteArray)           
            try headerData.write(to: fileURL)

            let savedData = try Data(contentsOf: fileURL)
            let bytes = Array(savedData)
            print(bytes)
        }
        catch {
            print("Error while writing image")
        }

    
    }

    // void unpack_color(const uint32_t &color, uint8_t &r, uint8_t &g, uint8_t &b, uint8_t &a) {
//     r = (color >>  0) & 255;
//     g = (color >>  8) & 255;
//     b = (color >> 16) & 255;
//     a = (color >> 24) & 255;
// }

//     void drop_ppm_image(const std::string filename, const std::vector<uint32_t> &image, const size_t w, const size_t h) {
//     assert(image.size() == w*h);
//     std::ofstream ofs(filename, std::ios::binary);
//     ofs << "P6\n" << w << " " << h << "\n255\n";
//     for (size_t i = 0; i < h*w; ++i) {
//         uint8_t r, g, b, a;
//         unpack_color(image[i], r, g, b, a);
//         ofs << static_cast<char>(r) << static_cast<char>(g) << static_cast<char>(b);
//     }
//     ofs.close();    
// }

    //print("\(framebuffer[1])")

    // std::vector<uint32_t> framebuffer(win_w*win_h, 255); // the image itself, initialized to red

    //print("\(Float(win_h))")

        func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    for j in 0..<win_h {
        for i in 0..<win_w {
            let r = UInt8((255 * j) / win_h) 
            let g = UInt8((255 * i) / win_w)
            let b = UInt8(0)
            let color = pack_color(r, g, b)
            print("Height \(j) Width \(i): \(r), \(g), \(b), \(color)")      
            framebuffer[i+j*win_w] = color      
        }
    }

    drop_ppm_image("./out.ppm", framebuffer, win_w, win_h);

  

    // for (size_t j = 0; j<win_h; j++) { // fill the screen with color gradients
    //     for (size_t i = 0; i<win_w; i++) {
    //         uint8_t r = 255*j/float(win_h); // varies between 0 and 255 as j sweeps the vertical
    //         uint8_t g = 255*i/float(win_w); // varies between 0 and 255 as i sweeps the horizontal
    //         uint8_t b = 0;
    //         framebuffer[i+j*win_w] = pack_color(r, g, b);
    //     }
    // }

    // drop_ppm_image("./out.ppm", framebuffer, win_w, win_h);

 

