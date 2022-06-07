using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using Sitecore;
using Sitecore.Configuration;
using Sitecore.Data;
using Sitecore.Data.Fields;
using Sitecore.Data.Items;
using Sitecore.Diagnostics;
using Sitecore.IO;
using Sitecore.Resources;
using Sitecore.Shell.Applications.ContentManager.Dialogs.SetIcon;
using Sitecore.Web;
using Sitecore.Web.UI;
using Sitecore.Web.UI.HtmlControls;

namespace SitecoreIcons
{
    public class SetIconForms : SetIconForm
    {
        protected Scrollbox FAList { get; set; }
        protected Scrollbox FAGreenList { get; set; }
        protected Scrollbox FABlueList { get; set; }
        protected Scrollbox FABlackList { get; set; }
        protected Scrollbox FARedList { get; set; }
        protected Scrollbox MUIList { get; set; }

        /// <summary>Raises the load event.</summary>
        /// <param name="e">The <see cref="T:System.EventArgs" /> instance containing the event data.</param>
        /// <remarks>This method notifies the server control that it should perform actions common to each HTTP
        /// request for the page it is associated with, such as setting up a database query. At this
        /// stage in the page lifecycle, server controls in the hierarchy are created and initialized,
        /// view state is restored, and form controls reflect client-side data. Use the IsPostBack
        /// property to determine whether the page is being loaded in response to a client postback,
        /// or if it is being loaded and accessed for the first time.</remarks>
        protected override void OnLoad(EventArgs e)
        {
            Assert.ArgumentNotNull(e, "e");
            base.OnLoad(e);
            TabStrip.OnChange += TabStrip_OnChange;
            if (!Context.ClientPage.IsEvent)
            {
                string queryString = WebUtil.GetQueryString("sc_content", Context.ContentDatabase.Name);
                Item itemFromQueryString = UIUtil.GetItemFromQueryString(Database.GetDatabase(queryString));
                Assert.IsNotNull(itemFromQueryString, typeof(Item));
                string queryString2 = WebUtil.GetQueryString("fld_id");
                if (string.IsNullOrEmpty(queryString2))
                {
                    IconFile.Value = itemFromQueryString.Appearance.Icon;
                }
                else
                {
                    Field field = itemFromQueryString.Fields[ID.Parse(queryString2)];
                    IconFile.Value = field.Value;
                }
                RenderIcons();
                RecentList.InnerHtml = RenderRecentIcons();
            }
        }

        // Sitecore.Shell.Applications.ContentManager.Dialogs.SetIcon.SetIconForm
        /// <summary>Renders the icons.</summary>
        private void RenderIcons()
        {
            RenderIcons(ApplicationsList, "Applications");
            RenderIcons(AppsList, "Apps");
            RenderIcons(BusinessList, "Business");
            RenderIcons(ControlsList, "Control");
            RenderIcons(Core1List, "Core");
            RenderIcons(Core2List, "Core2");
            RenderIcons(Core3List, "Core3");
            RenderIcons(DatabaseList, "Database");
            RenderIcons(FlagsList, "Flags");
            RenderIcons(ImagingList, "Imaging");
            RenderIcons(LaunchPadIconsList, "LaunchPadIcons");
            RenderIcons(MultimediaList, "Multimedia");
            RenderIcons(NetworkList, "Network");
            RenderIcons(OfficeList, "Office");
            RenderIcons(OfficeWhiteList, "OfficeWhite");
            RenderIcons(OtherList, "Other");
            RenderIcons(PeopleList, "People");
            RenderIcons(SoftwareList, "Software");
            RenderIcons(WordProcessingList, "WordProcessing");
            RenderIcons(FAList, "FA");
            RenderIcons(MUIList, "MUI");
            RenderIcons(FABlackList, "fa-green");
            RenderIcons(FABlueList, "fa-blue");
            RenderIcons(FAGreenList, "fa-green");
            RenderIcons(FARedList, "fa-red");
        }


        /// <summary>Renders the icons.</summary>
        /// <param name="scrollbox">The scrollbox.</param>
        /// <param name="prefix">The prefix.</param>
        private static void RenderIcons(Scrollbox scrollbox, string prefix)
        {
            Assert.ArgumentNotNull(scrollbox, "scrollbox");
            Assert.ArgumentNotNullOrEmpty(prefix, "prefix");
            string filename = GetFilename(prefix);
            string text = Path.ChangeExtension(filename, ".html");
            if (!File.Exists(filename) || !File.Exists(text))
            {
                DrawIcons(prefix, filename, text);
            }
            HtmlTextWriter htmlTextWriter = new HtmlTextWriter(new StringWriter());
            htmlTextWriter.Write(FileUtil.ReadFromFile(text));
            WriteImageTag(filename, prefix, htmlTextWriter);
            scrollbox.InnerHtml = htmlTextWriter.InnerWriter.ToString();
        }

        /// <summary>Gets the filename.</summary>
        /// <param name="prefix">The prefix.</param>
        /// <returns>Returns the filename.</returns>
        private static string GetFilename(string prefix)
        {
            return FileUtil.MapPath(FileUtil.MakePath(TempFolder.Folder, "icons_" + prefix + ".png"));
        }

        /// <summary>Draws the icons.</summary>
        /// <param name="prefix">The prefix.</param>
        /// <param name="img">The img.</param>
        /// <param name="area">The area.</param>
        private static void DrawIcons(string prefix, string img, string area)
        {
            string[] files = GetFiles(prefix);
            int num = files.Length;
            if (num == 0)
            {
                num = 1;
            }
            int height = (num / 24 + ((num % 24 != 0) ? 1 : 0)) * 40;
            using (Bitmap bitmap = new Bitmap(960, height, PixelFormat.Format32bppArgb))
            {
                if (prefix == "OfficeWhite")
                {
                    Graphics graphics = Graphics.FromImage(bitmap);
                    graphics.FillRectangle(Brushes.DarkGray, 0, 0, 960, height);
                }

                HtmlTextWriter htmlTextWriter = new HtmlTextWriter(new StringWriter());
                htmlTextWriter.WriteLine("<map name=\"" + prefix + "\">");
                string text = prefix + "/32x32/";
                int num2 = 0;
                using (Graphics graphics2 = Graphics.FromImage(bitmap))
                {
                    string[] array = files;
                    foreach (string text2 in array)
                    {
                        int num3 = num2 % 24;
                        int num4 = num2 / 24;
                        string themedImageSource = Images.GetThemedImageSource(text + text2, ImageDimension.id32x32);
                        try
                        {
                            using (Bitmap image = (Settings.Icons.UseZippedIcons
                                ? new Bitmap(ZippedIcon.GetStream(text + text2, ZippedIcon.GetZipFile(text)))
                                : new Bitmap(FileUtil.MapPath(themedImageSource))))
                            {
                                graphics2.DrawImage(image, num3 * 40 + 4, num4 * 40 + 4, 32, 32);
                            }

                            string arg = $"{num3 * 40 + 4},{num4 * 40 + 4},{num3 * 40 + 36},{num4 * 40 + 36}";
                            string arg2 =
                                StringUtil.Capitalize(Path.GetFileNameWithoutExtension(text2).Replace("_", " "));
                            htmlTextWriter.WriteLine(
                                "<area shape=\"rect\" coords=\"{0}\" href=\"#\" alt=\"{1}\" sc_path=\"{2}\"/>", arg,
                                arg2, text + text2);
                            num2++;
                        }
                        catch (Exception exception)
                        {
                            Log.Warn("Unable to open icon " + themedImageSource, exception, typeof(SetIconForm));
                        }
                    }
                }

                htmlTextWriter.WriteLine("</map>");
                FileUtil.WriteToFile(area, htmlTextWriter.InnerWriter.ToString());
                bitmap.Save(img, ImageFormat.Png);
            }
        }

        /// <summary>Gets the files.</summary>
        /// <param name="prefix">The prefix.</param>
        /// <returns>The files.</returns>
        private static string[] GetFiles(string prefix)
        {
            Assert.ArgumentNotNullOrEmpty(prefix, "prefix");
            if (!Settings.Icons.UseZippedIcons)
            {
                return GetFolderFiles(prefix);
            }
            return GetZippedFiles(prefix);
        }

        /// <summary>Gets the files.</summary>
        /// <param name="prefix">The prefix.</param>
        /// <returns>Returns the files.</returns>
        private static string[] GetFolderFiles(string prefix)
        {
            string[] files = Directory.GetFiles(FileUtil.MapPath("/sitecore/shell/themes/standard/" + prefix + "/32x32"));
            for (int i = 0; i < files.Length; i++)
            {
                files[i] = Path.GetFileName(files[i]);
            }
            return files;
        }

        /// <summary>Gets the zipped filed.</summary>
        /// <param name="prefix">The prefix.</param>
        /// <returns>Returns the zipped filed.</returns>
        private static string[] GetZippedFiles(string prefix)
        {
            return ZippedIcon.GetFiles(prefix, "/sitecore/shell/themes/standard/" + prefix + ".zip");
        }


        /// <summary>
        /// Writes the image tag.
        /// </summary>
        /// <param name="img">The img.</param>
        /// <param name="prefix">The prefix.</param>
        /// <param name="output">The output.</param>
        private static void WriteImageTag(string img, string prefix, HtmlTextWriter output)
        {
            Assert.ArgumentNotNull(img, "img");
            Assert.ArgumentNotNull(prefix, "prefix");
            Assert.ArgumentNotNull(output, "output");
            ImageBuilder imageBuilder;
            using (Bitmap bitmap = new Bitmap(img))
            {
                imageBuilder = new ImageBuilder
                {
                    Src = FileUtil.UnmapPath(img),
                    Width = bitmap.Width,
                    Height = bitmap.Height,
                    Usemap = "#" + prefix
                };
            }
            output.WriteLine(imageBuilder.ToString());
        }
    }
}
