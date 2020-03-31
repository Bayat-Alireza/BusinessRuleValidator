using System;
using System.Collections.Generic;
using System.IO;
using Saxon.Api;
using System.Xml;

namespace SchematronLogic
{
    public class XSLTransform
    {
        public Stream Transform(Uri xmluri, Uri xsluri)
        {


            // Create a Processor instance.
            Processor processor = new Processor();

            // Load the source document
            XdmNode input = processor.NewDocumentBuilder().Build(xmluri);

            // Create a transformer for the stylesheet.
            var compiler = processor.NewXsltCompiler();
            compiler.ErrorList = new List<StaticError>();

            XsltTransformer transformer = compiler.Compile(xsluri).Load();

            if (compiler.ErrorList.Count != 0)
                throw new Exception("Exception loading xsl!");

            // Set the root node of the source document to be the initial context node
            transformer.InitialContextNode = input;

            // Create a serializer
            Serializer serializer = processor.NewSerializer();
            MemoryStream results = new MemoryStream();
            serializer.SetOutputStream(results);

            // Transform the source XML to System.out.
            transformer.Run(serializer);

            //get the string
            results.Position = 0;
            return results;


        }

        public Stream Transform(Stream xmlstream, Stream xslstream)
        {

            // Create a Processor instance.
            Processor processor = new Processor();

            // Load the source document
            var documentbuilder = processor.NewDocumentBuilder();
            documentbuilder.BaseUri = new Uri("file://c:/");
            XdmNode input = documentbuilder.Build(xmlstream);

            // Create a transformer for the stylesheet.
            var compiler = processor.NewXsltCompiler();
            compiler.ErrorList = new List<StaticError>();
            compiler.XmlResolver = new XmlUrlResolver();
            XsltTransformer transformer = compiler.Compile(xslstream).Load();

            if (compiler.ErrorList.Count != 0)
                throw new Exception("Exception loading xsl!");

            // Set the root node of the source document to be the initial context node
            transformer.InitialContextNode = input;

            // Create a serializer
            Serializer serializer = processor.NewSerializer();
            MemoryStream results = new MemoryStream();
            serializer.SetOutputStream(results);

            // Transform the source XML to System.out.
            transformer.Run(serializer);

            //get the string
            results.Position = 0;
            return results;


        }

    }
}
