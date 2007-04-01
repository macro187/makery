// -----------------------------------------------------------------------------
// Copyright (c) 2007 Ron MacNeil <macro187 AT users DOT sourceforge DOT net>
//
// Permission to use, copy, modify, and distribute this software for any
// purpose with or without fee is hereby granted, provided that the above
// copyright notice and this permission notice appear in all copies.
//
// THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
// WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
// ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
// WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
// ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
// OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
// -----------------------------------------------------------------------------


using System;
using System.Collections;
using System.IO;
using System.Resources;



namespace
Net.Sourceforge.Resbian
{



/// <summary>
/// CommandPlugin for the <c>compile</c> command
/// </summary>
public class
CompileCommandPlugin
    : CommandPlugin
{



private ArrayList
plugins = new ArrayList();



public
CompileCommandPlugin()
{
    // Initialize filetype plugin list
    this.plugins.Add( new DefaultFilePlugin() );
    this.plugins.Add( new StringFilePlugin() );
    this.plugins.Add( new StringsFilePlugin() );
    //this.plugins.Add( new ImageFilePlugin() );
}



public override string
Help()
{
    return
    "<infiles> <outfile>\n" +
    "   <infiles> - files to compile as resources\n" +
    "   <outfile> - .resources file to output to\n" +
    "";
}



public override bool
Process(
    string[] args
)
{
    // Grab args
    ArrayList infiles = new ArrayList();
    string outfile;

    if( args.Length < 1 ) {
        throw new CmdArgException( "No <infiles> specified" );
    }
    for( int i = 0; i < args.Length-1; i++ ) {
        infiles.Add( args[i] );
    }

    if( args.Length < 2 ) {
        throw new CmdArgException( "No <outfile> specified" );
    }
    outfile = args[ args.Length-1 ];

    Resbian.WriteLine( String.Format( "Output file: '{0}'", outfile ) );


    // Create a ResourceWriter writing to the outfile
    ResourceWriter writer = new ResourceWriter( File.OpenWrite( outfile ) );


    // Process each input file, adding it's contents to the ResourceWriter
    foreach( string infile in infiles ) {

        if( !File.Exists( infile ) )
            throw new CmdArgException( String.Format(
                "Input file '{0}' doesn't exist", infile ) );

        Resbian.WriteLine( infile );


        // Try each filetype plugin until one works
        bool processed = false;
        for( int i = this.plugins.Count-1; i >= 0; i-- ) {
            FilePlugin plugin = (FilePlugin) this.plugins[ i ];

            if( plugin.Process( infile, writer ) ) {
                Resbian.WriteLine( String.Format(
                    "({0})", plugin.GetType().Name ), 1 );
                processed = true;
                break;
            }

        }

        if( !processed ) {
            throw new ApplicationException( String.Format(
                "Don't know how to process '{0}'", infile ) );
        }


    }


    // Tell the ResourceWriter to write out to the outfile then close it
    writer.Generate();
    writer.Close();


    return true;
}



} // class
} // namespace

