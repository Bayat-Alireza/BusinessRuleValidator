using System;
using System.IO;
using System.Threading.Tasks;
using System.Xml;

namespace SchematronLogic
{
    public class SchHelper
    {
        public static async Task Logger(Stream schematronError, string saveInPath)
        {
            using (var fileStream = File.Create(saveInPath))
            {
                schematronError.Seek(0, SeekOrigin.Begin);
                await schematronError.CopyToAsync(fileStream);
            }
        }
        public static async Task consoleLogErrorText(string path)
        {
            XmlReaderSettings setting = new XmlReaderSettings
            {
                Async = true
            };

            using (Stream error = new FileStream(path, FileMode.Open, FileAccess.Read))
            {
                using (XmlReader reader = XmlReader.Create(error, setting))
                {
                    XmlNamespaceManager nsmgr = new XmlNamespaceManager(reader.NameTable);
                    nsmgr.AddNamespace("svrl", "http://purl.oclc.org/dsdl/svrl");

                    while (await reader.ReadAsync())
                    {

                        if (reader.NodeType == XmlNodeType.Element && reader.Name == "svrl:text")
                        {
                            Console.WriteLine(reader.ReadElementContentAsString());
                        }
                    }
                }
            };

        }
        public static async void log(Stream schematronError, string saveInPath)
        {
            string path = Path.GetFullPath(Path.Combine("..", ".."));
            await Logger(schematronError, saveInPath);
            await consoleLogErrorText(path + @"\docs\schematronError.xml");
            Console.WriteLine("done");

        }
    }
}
