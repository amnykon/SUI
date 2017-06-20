# Installation

1. Clone this repository
```bash
git clone https://github.com/amnykon/SUI
```

2. Install SDL2 via Homebrew
```bash
brew install sdl2 sdl2_gfx sdl2_ttf sdl2_image
```

3. Run the `codegenerate` script
```bash
cd SUI
./codegenerate.sh
```

4. Open `module.modulemap` in your preferred text editor
```bash
vim .build/checkouts/CSDL2.swift.git-84403830401767267/module.modulemap
```

5. Replace all headers with: `/usr/local/include/`

6. Open `Package.swift` in your preferred text editor
```bash
vim .build/checkouts/CSDL2.swift.git-84403830401767267/Package.swift
```

7. Add `pkgconfig: "sdl2"` between `name` and `targets`
```swift
let package = Package(
      name: "CSDL2",
      pkgConfig: "sdl2",
      targets: [],
      dependencies: []
)
```

8. Open `sdl2.pc` in your preferred text editor
```bash
vim /usr/local/lib/pkgconfig/sdl2.pc
```

9. On line 15 remove: `-D_THREAD_SAFE`

10. Run the `codegenerate` script
```bash
./codegenerate.sh
```

11. Build
```bash
swift build
```

# Usage

### Run Tests

```bash
swift test
```

### Start Demo

```bash
.build/debug/SdlSuiDemo
```
