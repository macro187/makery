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
using System.Resources;
using System.IO;



namespace
Net.Sourceforge.Resbian
{



/// <summary>
/// A FilePlugin that adds the contents of files as <c>byte[]</c> resources
/// </summary>
/// <remarks>
/// The resource name will the everything after the <c>&lt;type&gt;>__</c>
/// prefix in the filename, include extension.
/// </remarks>
public class
DefaultFilePlugin
    : FilePlugin
{



public override bool
Process(
    string filename,
    ResourceWriter writer
)
{
    string name = this.GetLocalFilename( filename );
    byte[] data = File.ReadAllBytes( filename );

    WriteLine( String.Format( "Adding as byte[] named '{0}'", name ) );
    writer.AddResource( name, data );

    return true;
}



} // class
} // namespace

