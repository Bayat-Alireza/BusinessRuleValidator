using SchematronLogic;
using System;
using System.IO;

namespace BusinessRuleValidator
{
    class Program
    {
        static void Main(string[] args)
        {
            
            var path = Path.GetFullPath(Path.Combine("..",".."));

            Uri schematron = new Uri(@"file:\\" + path + @"\docs\schematron.sch");
            Uri schematronxsl = new Uri(@"file:\\" + path + @"\xsl_2\iso_svrl_for_xslt2.xsl");

            Console.WriteLine(path + @"\docs\message.xml");

            /////////////////////////////////
            //// Transform original Schemtron  
            /////////////////////////////////

            Stream schematrontransform = new XSLTransform().Transform(schematron, schematronxsl);

            ///////////////////////////////
            // Apply Schemtron xslt 
            ///////////////////////////////
            FileStream xmlstream = new FileStream(path + @"\docs\message.xml", FileMode.Open, FileAccess.Read, FileShare.Read);
            Stream results = new XSLTransform().Transform(xmlstream, schematrontransform);

            SchHelper.log(results, path + @"\docs\schematronError.xml");
            Console.ReadLine();
        }
    }
}
