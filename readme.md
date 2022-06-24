# Sitecore Icons

This repository makes possible usage FA and MUI icons for your Sitecore items

![image](https://user-images.githubusercontent.com/647813/175667101-3fa94782-6882-47d3-ade4-cb45353ce9a0.png)


You will get 1800+ FA and 2500+ MUI icons X 4 colors (Black, Blue, Green, Red)


## How to install

1. Go to [releases](https://github.com/Antonytm/sitecore-icons/releases)
1. Download latest release package
1. Login to Sitecore Desktop
1. Open Development Tools > Installation Wizard
1. Upload package that you have downloaded
1. Install it

## Packages List

1. SitecoreIcons-FontAwesome - Font Awesome icons in 4 colors: black, blue, green, red
1. SitecoreIcons-FontAwesome-Black - Font Awesome icons in black color
1. SitecoreIcons-FontAwesome-Blue - Font Awesome icons in blue color
1. SitecoreIcons-FontAwesome-Green - Font Awesome icons in green color
1. SitecoreIcons-FontAwesome-Red - Font Awesome icons in red color
1. SitecoreIcons-Full - Font Awesome icons and MUI icons in 4 colors: black, blue, green, red
1. SitecoreIcons-MUI - MUI Icons in 4 colors: black, blue, green, red
1. SitecoreIcons-MUI-Black - MUI Icons in black color
1. SitecoreIcons-MUI-Blue - MUI Icons in blue color
1. SitecoreIcons-MUI-Green - MUI Icons in green color
1. SitecoreIcons-MUI-Red - MUI Icons in red color

## How packages are built

1. FA (https://github.com/FortAwesome/Font-Awesome.git) is clonned as submodule
1. MUI (https://github.com/mui/material-ui.git) is clonned as submodule
1. We iterate trought all SVG files
1. We iterate thought all colors
1. We iterate thought all required sizes (16x16, 24x24, 32x32, 48x48, 128x128)
1. SVG is modified to have required size and color
1. SVG is converted to PNG using [ImageMagick](https://imagemagick.org/index.php)

## FAQ

1. Q: I have installed packages, but you don't see icons

   A: Try to clean up `\Website\temp` folder on you CM server

1. Q: I don't like color shades, I want to change them

   A: Open `/scripts/Generic.ps1` and change $colors variable

1. Q: I want to add more colors or replace existing

   A: Open `/scripts/Generic.ps1` and change $colors variable. Open `SitecoreIcons.sln` in VS and configure colors that you need

1. Q: Can I trust package content?

   A: All packages are build using GitHub actions and you can review whole [process](https://github.com/Antonytm/sitecore-icons/actions).

1. Q: Do icons license allow their usage?

   A: Yes. FA has CC By 4.0 License. MUI has MIT License.
   
1. Q: I want to change and build packages by myself

   A: You need to fork repository and create tag in format `v....`. It will trigger new build.

1. Q: I want to build pakages locally

   A: Run `./scripts/local.ps1` using Powershell

1. Q: How many icons will I get?

   A: 1800+ FA icons + 2500+ MUI icons
   
1. Q: I don't want to have all colors

   A: You may to install only packages with colors that you need

1. Q: Icons dialog is too slow

   A: It is slow only the first time. Sitecore will make a cache, located in `\Website\temp`. If cache is cleared then it will take to load long time again.

1. Q: I want to use it will Docker

   A: No problem, but you need to map `\Website\temp` folder to avoid rebuild icons cache on each container restart


## Licenses

1. MUI Icons: [MIT License](https://github.com/mui/material-ui/blob/master/LICENSE)
1. FA Icons: [CC By 4.0 License](https://github.com/FortAwesome/Font-Awesome/blob/6.x/LICENSE.txt)
1. This repository: [MIT License](https://opensource.org/licenses/MIT)

## Thanks to

1. Viet Hoang, who wrote [article](https://buoctrenmay.com/2017/06/17/how-to-inject-the-custom-icons-to-sitecore-8/) about icons many years ago.
1. MUI [authors](https://github.com/muicss/mui/blob/master/AUTHORS.txt)
1. FA [authors](https://rstudio.github.io/fontawesome/authors.html)
