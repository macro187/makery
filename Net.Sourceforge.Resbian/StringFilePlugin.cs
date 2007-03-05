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
/// FilePlugin that adds the contents of
/// <c>&lt;type&gt;__&lt;name&gt;.string.txt</c> text files as <c>string</c>
/// resources
/// </summary>
/// <remarks>
/// The resource will be named <c>&lt;name&gt;</c>.
/// </remarks>
public class
StringFilePlugin
	: FilePlugin
{


private static readonly string
SUFFIX = ".string.txt";


public override bool
Process(
	string filename,
	ResourceWriter writer
)
{
	string name;
	string local = this.GetLocalFilename( filename );
	if( !local.EndsWith( SUFFIX ) )
		return false;
	name = local.Substring( 0, (local.Length-SUFFIX.Length) );

	string data = File.ReadAllText( filename );

	WriteLine( String.Format( "Adding as string named '{0}'", name ) );
	writer.AddResource( name, data );

	return true;
}



} // class
} // namespace

