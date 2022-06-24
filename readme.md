## How to install

1. Go to [releases](https://github.com/Antonytm/sitecore-icons/releases)
1. Download latest release package
1. Login to Sitecore Desktop
1. Open Development Tools > Installation Wizard
1. Upload package that you have downloaded
1. Install it

## Pacakges List

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



## Licenses

1. MUI Icons: [MIT License](https://github.com/mui/material-ui/blob/master/LICENSE)
1. FA Icons: [CC By 4.0 License](https://github.com/FortAwesome/Font-Awesome/blob/6.x/LICENSE.txt)
1. This repository: [MIT License](https://opensource.org/licenses/MIT)

## Thanks

1. Viet Hoang, who wrote [article](https://buoctrenmay.com/2017/06/17/how-to-inject-the-custom-icons-to-sitecore-8/) about icons many years ago.
1. MUI [authors](https://github.com/muicss/mui/blob/master/AUTHORS.txt)
1. FA [authors](https://rstudio.github.io/fontawesome/authors.html)
